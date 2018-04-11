const bindConfirm = (element) => {
  element.addEventListener("click", (event) => {
      event.preventDefault();
      const movie_title = document.getElementById("movie_title").value;
      search_movie(movie_title);
  });
};

const bindfilmbutton = (element) => {
  element.addEventListener("click", (event) => {
      event.preventDefault();
      const film_title_title = document.getElementById("film_title_title");
      const film_title_imdb_id = document.getElementById("film_title_imdb_id");
      const create_film = document.getElementById("create_film");
      film_title_title.value = element.dataset.movieTitle
      film_title_imdb_id.value = element.dataset.movieId
      console.log(element.dataset.movieTitle)
      //create_film.click()

  });
};

document.querySelectorAll("#btn-search").forEach(bindConfirm);

const movies = document.getElementById("movie_list");

const search_movie = (movie_title) => {
const api_key = "5540735874a63598d8aff185327238bb";
  fetch(`https://api.themoviedb.org/3/search/movie?api_key=${api_key}&language=en-US&query='${movie_title}'&page=1&include_adult=false`)
  .then(response => response.json())
  .then((data) => {
    data.results.forEach((movie) => {
      const item = `
        <li> <strong> ${movie.title} </strong> - Release date: ${movie.release_date} - ${movie.id} - </li>
        <a
          href="#"
          class="btn-add-film"
          data-movie-title = "${movie.title}"
          data-movie-id = ${movie.id}
        >
          ADD FILM
        </a>
      `;
      movies.insertAdjacentHTML("beforeend", item);
      document.querySelectorAll(".btn-add-film").forEach(bindfilmbutton);

    });
  });
}
