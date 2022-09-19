defmodule Remote.Builder do
  # mix run scripts/demo.exs
  def build(folder, tools, _files, deps) do
    File.mkdir_p!(folder)
    tools = build_tools(tools, [])
    tools = Enum.join(tools, "\n")
    tools_p = Path.join(folder, ".tool-versions")
    File.write!(tools_p, [tools, "\n"])
    build_install(folder, deps)
  end

  defp build_install(folder, deps) do
    deps = build_deps(deps, [])
    deps = Enum.join(deps, ",\n ")
    install_p = Path.join(folder, "install.exs")

    File.write!(install_p, """
    folder = Path.dirname(__ENV__.file)
    otp_release = :erlang.system_info(:otp_release)
    root_dir = :code.root_dir()
    release_path = Path.join([root_dir, "releases", otp_release, "OTP_VERSION"])
    erlang_version = File.read!(release_path) |> String.trim()
    elixir_version = System.version()
    otp_release = System.otp_release()
    releases = [
      elixir_version,
      erlang_version,
      otp_release] |> Enum.join("\\n")
    env = System.get_env()
      |> Enum.map(fn {k,v} -> "\#{k}: \#{v}\n" end)
    File.write!(Path.join(folder, "env"), env)
    build = Path.join(folder, "build")
    paths = Path.join(folder, "paths")
    versions = Path.join(folder, "versions")
    System.put_env("MIX_INSTALL_DIR", build)
    Mix.install([
      #{deps}
    ])
    code_paths = :code.get_path()
      |> Enum.map(&List.to_string/1)
      |> Enum.filter(&(String.starts_with?(&1, build)))
      |> Enum.join("\\n")
    File.write!(paths, [code_paths, "\\n"])
    File.write!(versions, [releases, "\\n"])
    :erlang.halt()
    """)
  end

  defp build_tools([], data), do: Enum.reverse(data)

  defp build_tools([tool | tools], data) do
    {name, version} = tool
    tool = "#{name} #{version}"
    data = [tool | data]
    build_tools(tools, data)
  end

  defp build_deps([], data), do: Enum.reverse(data)

  defp build_deps([dep | deps], data) do
    {name, props} = dep
    props = build_props(props, [])
    props = Enum.join(props, ", ")
    dep = "{:#{name}, #{props}}"
    data = [dep | data]
    build_deps(deps, data)
  end

  defp build_props([], data), do: Enum.reverse(data)

  defp build_props([prop | props], data) do
    {name, value} = prop
    prop = build_prop("#{name}", value)
    data = [prop | data]
    build_props(props, data)
  end

  defp build_prop("hex", value), do: "#{inspect(value)}"
  defp build_prop("git", value), do: "git: #{inspect(value)}"
  defp build_prop("path", value), do: "path: #{inspect(value)}"
end
