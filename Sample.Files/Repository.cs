using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

#nullable enable
namespace Sample.Files
{
    public static class Repository
    {
        public static IEnumerable<string> Names
        {
            get
            {
                return typeof(Repository)
                    .Assembly
                    .GetManifestResourceNames()
                    .Where(n => n.IndexOf("Sample.Files.Resources.") == 0)
                    .Select<string, string>(s => s.Replace("Sample.Files.Resources.", ""));
            }
        }

        public static List<string> PathNames
        {
            get
            {
                var names = new List<string>(Names);
                var pathNames = new List<string>();
                var dirNames = new string[] { "Text", "Image", "Json", "Xaml", "Yaml" };
                foreach(var name in names)
                {
                    var pathName = name;
                    foreach(var dirname in dirNames)
                    {
                        if (pathName.IndexOf($"{dirname}.") == 0)
                        {
                            pathName = $"{dirname}/" + name.Substring($"{dirname}.".Length);
                        }
                    }
                    
                    pathNames.Add(pathName);
                }
                return pathNames;
            }
        }

        public static Stream? GetStream(string name)
        {
            return typeof(Repository)
                .Assembly
                .GetManifestResourceStream($"Sample.Files.Resources.{name.Replace("/",".")}");
        }

        public static string GetFileName(string name)
        {
            var stream = GetStream(name);
            if (stream is null) return string.Empty;
            var filename = Path.GetTempPath() + $"Sample.Files{Path.DirectorySeparatorChar}{name}";
            var fileInfo = new FileInfo(filename);
            if (!fileInfo.Directory.Exists) fileInfo.Directory.Create();
            if (!File.Exists(filename))
            {
                using var fs = new FileStream(filename, FileMode.Create);
                stream.CopyTo(fs);
            }
            return filename;
        }
    }
}
#nullable disable