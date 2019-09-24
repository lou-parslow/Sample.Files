require 'raykit'

task :default do
	PROJECT.info
	target='Mocks.Net.Test/obj/Mocks.Net.Test.csproj.nuget.cache'
	CLEAN.exclude(target)
	if(PROJECT.last_modified_filename != target)
		PROJECT.run(["dotnet build --configuration Release",
					"dotnet pack #{PROJECT.name}.sln -c Release",
					"dotnet test #{PROJECT.name}.Test/#{PROJECT.name}.Test.csproj -c Release -v normal"])

		#list=`nuget list Sample.Files -Source nuget.org`
		#if(!list.include?("Sample.Files #{PROJECT.version}"))
			NUGET_KEY=ENV['NUGET_KEY']
			Dir.chdir("#{PROJECT.name}/bin/Release") do
				PROJECT.run("dotnet nuget push #{PROJECT.name}.#{PROJECT.version}.nupkg -k #{NUGET_KEY} -s https://api.nuget.org/v3/index.json",false)
			end
		#end

		PROJECT.commit.tag.push.pull
	end
	PROJECT.summary
end