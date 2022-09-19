#mix run scripts/demo.exs
alias Remote.Builder

home = System.user_home!()
folder = "/tmp/builder"
tools = [{"elixir", "1.13.4-otp-25"}, {"erlang", "25.0.2"}]
files = nil
deps = [
  {:terminal, git: "https://github.com/samuelventura/terminal"}
]
Builder.build folder, tools, files, deps

paths = "#{home}/.asdf/shims:#{home}/.asdf/bin:/usr/sbin:/usr/bin:/sbin:/bin"
File.cd!(folder)
System.cmd("bash", ["-c", "iex install.exs"], env: [
  {"PWD", folder},
  {"PATH", paths},
  {"ROOTDIR", nil}, #/home/samuel/.asdf/installs/erlang/25.0.4
  {"BINDIR", nil}, #/home/samuel/.asdf/installs/erlang/25.0.4/erts-13.0.4/bin
  {"MIX_HOME", nil}, #/home/samuel/.asdf/installs/elixir/1.14-otp-25/.mix
  {"MIX_ARCHIVES", nil}, #/home/samuel/.asdf/installs/elixir/1.14-otp-25/.mix/archives
])

#cd /tmp/builder
#ls -a /tmp/builder
#cat /tmp/builder/install.exs
#iex /tmp/builder/install.exs
#find /tmp/builder/build
#cat /tmp/builder/paths
#cat /tmp/builder/versions
#cat /tmp/builder/.tools-versions
#rm -fr /tmp/builder
