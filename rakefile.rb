NAME='Sample.Files'
require 'raykit'

task :info do
	PROJECT.info
end

task :build do
	Raykit::run("dotnet build --configuration Release")
end

task :test do
	Raykit::run("dotnet test #{NAME}.Test/#{NAME}.Test.csproj -c Release -v normal")
end

task :publish  do
	
	list=`nuget list Sample.Files -Source nuget.org`
	if(!list.include?("Sample.Files #{PROJECT.version}"))
		NUGET_KEY=ENV['NUGET_KEY']
		Dir.chdir("#{NAME}/bin/Release") do
			Raykit::run("dotnet nuget push #{NAME}.#{PROJECT.version}.nupkg -k #{NUGET_KEY} -s https://api.nuget.org/v3/index.json")
		end
		#FileUtils.cp("#{NAME}/bin/Release/#{NAME}.#{VERSION}.nupkg","#{NAME}.#{VERSION}.nupkg")
		#puts `nuget push Sample.Files.#{VERSION}.nupkg -Source https://api.nuget.org/v3/index.json`
	end
end

task :push do
	PROJECT.commit.push.tag
end

task :default => [:publish,:push]
