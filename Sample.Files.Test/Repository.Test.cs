using NUnit.Framework;
using System.Collections.Generic;
using System.IO;

namespace Sample.Files
{
    public class RepositoryTest
    {
        [Test]
        public void Usage()
        {
            var names = new List<string>(Repository.Names);
            Assert.True(names.Contains("Text.ASCII.1MB.txt"),"Text.ASCII.1MB.txt");
            Assert.NotNull(Repository.GetStream("Text.ASCII.1MB.txt"), "GetStream Text.ASCII.1MB.txt");
            var filename = Repository.GetFileName("Text.ASCII.1MB.txt");
            Assert.True(File.Exists(filename),filename);
        }
    }
}