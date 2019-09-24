require 'raykit'

task :default do
    PROJECT.info.run(["dotnet build --configuration Release",
				 "dotnet pack #{PROJECT.name}.sln -c Release",
				 "dotnet test #{PROJECT.name}.Test/#{PROJECT.name}.Test.csproj -c Release -v normal"])

	list=`nuget list Sample.Files -Source nuget.org`
	if(!list.include?("Sample.Files #{PROJECT.version}"))
		NUGET_KEY=ENV['NUGET_KEY']
		Dir.chdir("#{NAME}/bin/Release") do
			PROJECT.run("dotnet nuget push #{PROJECT.name}.#{PROJECT.version}.nupkg -k #{NUGET_KEY} -s https://api.nuget.org/v3/index.json",false)
		end
	end

    PROJECT.commit.tag.push.pull.summary
end


#NAME='Sample.Files'
#require 'raykit'

#task :info do PROJECT.info end
#task :build do PROJECT.run("dotnet build --configuration Release") end
#task :test => [:build] do PROJECT.run("dotnet test #{NAME}.Test/#{NAME}.Test.csproj -c Release -v normal") end

task :publish => [:test]  do
	list=`nuget list Sample.Files -Source nuget.org`
	#puts list
	if(!list.include?("Sample.Files #{PROJECT.version}"))
		NUGET_KEY=ENV['NUGET_KEY']
		Dir.chdir("#{NAME}/bin/Release") do
			PROJECT.run("dotnet nuget push #{NAME}.#{PROJECT.version}.nupkg -k #{NUGET_KEY} -s https://api.nuget.org/v3/index.json",false)
		end
	end
end

#task :push do
#	PROJECT.commit.push.tag
#end

#task :default => [:publish,:push]
