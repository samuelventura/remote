# Remote

Elixir remote control

## Use Cases

- Compile app with matching remote versions
- Transfer ebin, and run app in remote VM
- Manage installed apps from remote shell

## Development

```elixir
otp_release = :erlang.system_info(:otp_release)
root_dir = :code.root_dir()
release_path = Path.join([root_dir, "releases", otp_release, "OTP_VERSION"])
File.read!(release_path) |> String.trim()
"25.0.2"
iex(8)> System.version
"1.13.4"
iex(16)> System.otp_release()
"25"
iex(17)> System.build_info()
%{
  build: "1.13.4 (compiled with Erlang/OTP 25)",
  date: "2022-05-18T15:27:25Z",
  otp_release: "25",
  revision: "7e4fbe6",
  version: "1.13.4"
}
iex(9)> :erlang.system_info(:otp_release) |> List.to_string()
"25"
iex(13)> :erlang.system_info(:version) |> List.to_string()
"13.0.2"
#cat .tool-versions
elixir 1.13.4-otp-25
erlang 25.0.2
```
