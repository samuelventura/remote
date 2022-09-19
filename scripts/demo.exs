#mix run scripts/demo.exs
alias Remote.Builder

folder = "/tmp/builder"
tools = [{"elixir", "1.13.4-otp-25"}, {"erlang", "25.0.2"}]
files = nil
deps = [
  {:terminal, git: "https://github.com/samuelventura/terminal"}
]
Builder.build folder, tools, files, deps

File.cd!(folder)
home = System.user_home!()
paths = "#{home}/.asdf/shims:#{home}/.asdf/bin:/usr/sbin:/usr/bin:/sbin:/bin"
System.cmd("bash", ["-c", "iex install.exs"], env: [{"PATH", paths}])

#cd /tmp/builder
#ls -a /tmp/builder
#cat /tmp/builder/install.exs
#iex /tmp/builder/install.exs
#find /tmp/builder/build
#cat /tmp/builder/paths
#cat /tmp/builder/versions
#cat /tmp/builder/.tools-versions
#rm -fr /tmp/builder
