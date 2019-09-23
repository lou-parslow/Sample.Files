NAME='Sample.Files'
require 'raykit'

task :info => PROJECT.info
task :build => Raykit::run("dotnet build --configuration Release")
task :test => Raykit::run("dotnet test #{NAME}.Test/#{NAME}.Test.csproj -c Release -v normal")

task :publish  do
	list=`nuget list Sample.Files -Source nuget.org`
	puts list
	if(!list.include?("Sample.Files #{PROJECT.version}"))
		NUGET_KEY=ENV['NUGET_KEY']
		Dir.chdir("#{NAME}/bin/Release") do
			Raykit::run("dotnet nuget push #{NAME}.#{PROJECT.version}.nupkg -k #{NUGET_KEY} -s https://api.nuget.org/v3/index.json")
		end
	end
end

task :push => PROJECT.commit.push.tag
task :default => [:publish,:push]
