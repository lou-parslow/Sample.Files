require 'dotkit'

task :default do
	#PROJECT.info
	target='Sample.Files.Test/obj/Release/netcoreapp2.0/Sample.Files.Test.csproj.CopyComplete'
	CLEAN.exclude(target)
	if(PROJECT.last_modified_filename != target)
		PROJECT.run(["dotnet build --configuration Release",
					"dotnet test #{PROJECT.name}.Test/#{PROJECT.name}.Test.csproj -c Release -v normal",
					"dotnet pack #{PROJECT.name}.sln -c Release"])

		NUGET_KEY=ENV['NUGET_KEY']
		PROJECT.run("dotnet nuget push #{PROJECT.name}/bin/Release/#{PROJECT.name}.#{PROJECT.version}.nupkg -s https://api.nuget.org/v3/index.json -k #{NUGET_KEY}",false)
		#NUGET_KEY=ENV['NUGET_KEY']
		#PROJECT.run("dotnet nuget push #{PROJECT.name}/bin/Release/#{PROJECT.name}.#{PROJECT.version}.nupkg -k #{NUGET_KEY} -s https://api.nuget.org/v3/index.json",false)

		#PROJECT.commit.tag.push.pull
	end
	#PROJECT.summary
end