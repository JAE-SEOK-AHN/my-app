import React from 'react';
import './Movie.css';

function Movie({title, poster}) {    
    return(
        <div>
            <MoviePoster poster={poster}/>
            <h1>{title}</h1>
        </div>
        )
}


function MoviePoster({poster}){    
    return(
           <img src={poster} alt="Movie Poster" />
        )
}


export default Movie;
