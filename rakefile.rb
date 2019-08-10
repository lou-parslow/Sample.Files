NAME='Sample.Files'
VERSION='0.0.5'
require 'dev'

task :setup do
	puts `nuget restore #{NAME}.sln`
end

task :publish  do
	list=`nuget list Sample.Files -Source nuget.org`
	if(!list.include?("Sample.Files #{VERSION}"))
		FileUtils.cp("#{NAME}/bin/Release/#{NAME}.#{VERSION}.nupkg","#{NAME}.#{VERSION}.nupkg")
		puts `nuget push Sample.Files.#{VERSION}.nupkg -Source https://api.nuget.org/v3/index.json`
	end
end
