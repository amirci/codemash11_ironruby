using MavenThought.Commons.Testing;
using SharpTestsEx;

namespace MavenThought.MovieLibrary.Tests
{
    /// <summary>
    /// Specification when adding a movie
    /// </summary>
    [Specification]
    public class When_movie_library_adds_a_movie : SimpleMovieLibrarySpecification
    {
        /// <summary>
        /// Movie to add
        /// </summary>
        private IMovie _movie;

        /// <summary>
        /// Checks that the movie is added to the library
        /// </summary>
        [It]
        public void Should_add_the_movie_to_the_library()
        {
            this.Sut.Contents
                .Should()
                .Have.SameSequenceAs(new[] { _movie });
        }

        /// <summary>
        /// Setup the movie
        /// </summary>
        protected override void GivenThat()
        {
            base.GivenThat();

            this._movie = Mock<IMovie>();
        }

        /// <summary>
        /// Add the movie
        /// </summary>
        protected override void WhenIRun()
        {
            this.Sut.Add(_movie);
        }
    }
}