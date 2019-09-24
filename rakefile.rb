require 'raykit'

task :default do
    PROJECT.info.run(["dotnet build --configuration Release",
				 "dotnet pack quemulus.standard.sln -c Release",
				 "dotnet test #{PROJECT.name}.Test/#{PROJECT.name}.Test.csproj -c Release -v normal"])

    PROJECT.commit.tag.push.pull.summary
end

#NAME='Sample.Files'
#VERSION='0.0.7'
#require 'dev'

#task :setup do
#	puts `nuget restore #{NAME}.sln`
#end

#task :publish  do
#	list=`nuget list Sample.Files -Source nuget.org`
#	if(!list.include?("Sample.Files #{VERSION}"))
#		FileUtils.cp("#{NAME}/bin/Release/#{NAME}.#{VERSION}.nupkg","#{NAME}.#{VERSION}.nupkg")
#		puts `nuget push Sample.Files.#{VERSION}.nupkg -Source https://api.nuget.org/v3/index.json`
#	end
#end
