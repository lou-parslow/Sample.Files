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
            Assert.True(names.Contains("Text.ASCII.1KB.txt"),"Text.ASCII.1KB.txt");
            Assert.NotNull(Repository.GetStream("Text.ASCII.1KB.txt"), "GetStream Text.ASCII.1MK.txt");
            var filename = Repository.GetFileName("Text.ASCII.1KB.txt");
            Assert.True(File.Exists(filename),filename);

            filename = Repository.GetFileName("Text.Lorum.Ipsum.txt");
            Assert.True(File.Exists(filename), filename);
        }

        [Test]
        [TestCase("Text.ASCII.1KB.txt")]
        [TestCase("Text/ASCII.1KB.txt")]
        public void GetStream(string name)
        {
            Assert.NotNull(Repository.GetStream(name), name);
        }
    }
}