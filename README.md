# Remote

Elixir remote control

## Use Cases

- Compile app with matching remote versions
- Transfer ebin, and run app in remote VM
- Manage installed apps from remote shell

## Development

```elixir
# /home/samuel/.cache/mix/installs/elixir-1.14.0-erts-13.0.4
# ./Library/Caches/mix/installs/
# overriden with MIX_INSTALL_DIR

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
#nerves has no OTP_VERSION file
iex(target@172.31.255.9)4> ls "/srv/erlang/releases/25"          
0.1.0              COOKIE             start_erl.data
```
