defmodule Remote.Versions do
  def elixir(), do: System.version()

  def erlang() do
    otp_release = :erlang.system_info(:otp_release)
    root_dir = :code.root_dir()
    release_path = Path.join([root_dir, "releases", otp_release, "OTP_VERSION"])
    File.read!(release_path) |> String.trim()
  end

  def otp(), do: System.otp_release()
end
