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