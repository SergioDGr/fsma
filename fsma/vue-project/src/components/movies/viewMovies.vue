<!--El componente donde se muestra las peliculas-->
<template>
    <!--Para visualizar el componente buscador-->
    <router-view></router-view>
    <!--Donde estas las peliculas-->
    <div class="app-body container">
        <!--Titulo-->
        <h1 class="text-center">{{$t('Movies.Title')}}</h1>
        <div class="row justify-content-center movies">
            <div class="card col-5 col-md-3 col-lg-2" v-for="movie in movies" :key="movie.id">
                <movie-card :id="movie.id" :image="base_img+movie.poster_path" :title="movie.title"></movie-card>
            </div>
        </div>
    </div>
</template>

<script>
import { getMovies, getMoviesTrending , getTopMovies, getUpcomingMovies } from "../services/ApiService";
import { API_IMG_URL } from '../../config/env.js';
import movieCard from './MovieCard.vue';


export default {
    data(){
        return{
            movies: this.$store.state.movies,
            base_img: API_IMG_URL,
            page: 1,
            pelisGuardadas: false
        }
    },
    //Metodos
    methods:{
        //Conseguir los datos para las peliculas
        async getData(newMovies = []){
            console.log("Peliculas peticion numero: " + this.page);
            if (this.movies.length != 0){
                newMovies = await this.getMoviesFor()
                this.movies.push(...newMovies)
            }else{
                this.movies = await this.getMoviesFor()
            }
            this.page++;
            this.pelisGuardadas = false;
        },
        //Metodo que añade al evento scroll la funcion scroll
        getNextMovies(){
            window.addEventListener('scroll',this.scroll, false)
        },
        //Al scrollear hasta el final pedira mas para añadir peliculas
        scroll(){
            let bottomOfWindow = document.documentElement.scrollTop + window.innerHeight === document.documentElement.scrollHeight;        
            if (bottomOfWindow && this.pelisGuardadas == false) {
                this.getData()
                this.pelisGuardadas = true;
            }
        },
        //Elimar el evento del scroll
        removeScrollEvent(){
            window.removeEventListener('scroll', this.scroll, false);
        },
        //Dependiendo de la ruta da unas peliculas otras
        async getMoviesFor(){
            switch (this.$route.name) {
                case 'Movie_Most_Rated':
                    return await getTopMovies(this.page)
                case 'Movie_Tranding':
                    return await getMoviesTrending(this.page)
                case 'Movie_upcoming':
                    return await getUpcomingMovies(this.page)
                default:
                    return await getMovies(this.page,'ES')
            }
        }
    },
    //Antes de montar añadir evento de scroll y inicializar el array de peliculas
    async beforeMount(){
        this.getNextMovies();
        await this.getData();
    },
    //Componentes que se utilizan
    components:{
        movieCard
    },
    //Eliminar evento scroll antes de moverse de cambiar la ruta
    beforeRouteLeave(){
        this.removeScrollEvent()
    }
}
</script>

<style>
div.row{
    margin: 0;
}
div.card{
    padding: 0%;
    margin: 0.5%;
}
img{
    width: 100%;
}
</style>