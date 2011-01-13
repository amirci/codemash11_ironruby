using MavenThought.Commons.Testing;
using SharpTestsEx;

namespace MavenThought.MovieLibrary.Tests
{
    /// <summary>
    /// Base specification for SimpleMovieLibrary
    /// </summary>
    public abstract class SimpleMovieLibrarySpecification
        : AutoMockSpecificationWithNoContract<SimpleMovieLibrary>
    {
    }
}