<!--Home-->
<template>
    <!--Visualizar el buscador-->
    <router-view :key="this.$route.path"></router-view>
    <!--Contenedor Home-->
    <div class="app-body container">
        <div class="home">
            <!--Titulo-->
            <h1 class="text-center">{{ $t('Home.Title') }}</h1>
            <div class="movies">
                <!--Titulo del apartado de las peliculas-->
                <h2>{{ $t('Home.Movies.Title') }}</h2>
                <!--Peliculas en tendencia-->
                <div>
                    <div class="d-flex justify-content-between">
                        <h3>{{ $t('Home.Movies.Trending') }}</h3>
                        <router-link :to="{name:'Movie_Tranding'}" class="btn btn-outline-primary ">{{ $t('Home.View') }}</router-link>
                    </div>
                    <div class="row justify-content-center justify-content-around ">
                        <div class="card col-5 col-md-3 col-lg-2" v-for="(movie,idx) in moviesTranding.slice(0,this.cantPelis)" :key="idx">
                            <movie-card :id="movie.id" :image="base_img+movie.poster_path" :title="movie.title"></movie-card>
                        </div>
                    </div>
                </div>
                <hr>
                <!--Pelicula Mas Votadas-->
                <div>
                    <div class="d-flex justify-content-between">
                        <h3>{{ $t('Home.Movies.Rated') }}</h3>
                        <router-link :to="{name:'Movie_Most_Rated'}" class="btn btn-outline-primary ">{{ $t('Home.View') }}</router-link>
                    </div>
                    <div class="row justify-content-center justify-content-around ">
                        <div class="card col-5 col-md-3 col-lg-2" v-for="(movie,idx) in topMovies.slice(0,this.cantPelis)" :key="idx">
                            <movie-card :id="movie.id" :image="base_img+movie.poster_path" :title="movie.title"></movie-card>
                        </div>
                    </div>
                </div>
                <hr>
                <!--Siguientes Peliculas-->
                <div>
                    <div class="d-flex justify-content-between">
                        <h3>{{ $t('Home.Movies.Upcoming') }}</h3>
                        <router-link :to="{name:'Movie_upcoming'}" class="btn btn-outline-primary ">{{ $t('Home.View') }}</router-link>
                    </div>
                    <div class="row justify-content-center justify-content-around ">
                        <div class="card col-5 col-md-3 col-lg-2" v-for="(movie,idx) in uncomingMovies.slice(0,this.cantPelis)" :key="idx">
                            <movie-card :id="movie.id" :image="base_img+movie.poster_path" :title="movie.title"></movie-card>
                        </div>
                    </div>
                </div>
            </div>
            <div class="series">
                <!--Titulo del apartado de las series-->
                <h2>{{ $t('Home.Series.Title') }}</h2>
                <div>
                    <!--Series en tendencia-->
                    <div class="d-flex justify-content-between">
                        <h3>{{ $t('Home.Series.Trending') }}</h3>
                        <router-link :to="{name:'Serie_Tranding'}" class="btn btn-outline-primary ">{{ $t('Home.View') }}</router-link>
                    </div>
                    <div class="row justify-content-center justify-content-around ">
                        <div class="card col-5 col-md-3 col-lg-2" v-for="(serie,idx) in seriesTranding.slice(0,this.cantPelis)" :key="idx">
                            <serie-card :id="serie.id" :image="base_img+serie.poster_path" :title="serie.name"></serie-card>
                        </div>
                    </div>
                </div>
                <hr>
                <!--Series mas votadas-->
                <div>
                    <div class="d-flex justify-content-between">
                        <h3>{{ $t('Home.Series.Rated') }}</h3>
                        <router-link :to="{name:'Serie_Most_Rated'}" class="btn btn-outline-primary ">{{ $t('Home.View') }}</router-link>
                    </div>
                    <div class="row justify-content-center justify-content-around ">
                        <div class="card col-5 col-md-3 col-lg-2" v-for="(serie,idx) in topSeries.slice(0,this.cantPelis)" :key="idx">
                            <serie-card :id="serie.id" :image="base_img+serie.poster_path" :title="serie.name"></serie-card>
                        </div>
                    </div>
                </div>
                <hr>
                <!--Series mas populares-->
                <div>
                    <div class="d-flex justify-content-between">
                        <h3>{{ $t('Home.Series.Popular') }}</h3>
                        <router-link :to="{name:'Series'}" class="btn btn-outline-primary ">{{ $t('Home.View') }}</router-link>
                    </div>
                    <div class="row justify-content-center justify-content-around ">
                        <div class="card col-5 col-md-3 col-lg-2" v-for="(serie,idx) in popularSeries.slice(0,this.cantPelis)" :key="idx">
                            <serie-card :id="serie.id" :image="base_img+serie.poster_path" :title="serie.name"></serie-card>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { getMoviesTrending,getTopMovies, getUpcomingMovies, getTopSeries,getSeriesTrending, getSeries } from '../services/ApiService';
import { API_IMG_URL } from '../../config/env.js';
import movieCard from '../movies/MovieCard.vue';
import serieCard from '../series/SerieCard.vue';

export default {
    data(){
        return{
            moviesTranding: [],
            topMovies: [],
            uncomingMovies: [],
            topSeries: [],
            seriesTranding: [],
            base_img: API_IMG_URL,
            popularSeries: [],
            cantPelis: 0
        }
    },
    async beforeMount(){
        await this.getData()
        console.log(this.$route);
    },
    //Metodos
    methods:{
        //Conseguir datos para las series y peliculas
        async getData(){
            console.log('Peliculas en tendencia:');
            this.moviesTranding = await getMoviesTrending(1);
            console.log('Peliculas top:');
            this.topMovies = await getTopMovies(1);
            console.log('Proximas peliculas:')
            this.uncomingMovies = await getUpcomingMovies(1,'ES');
            console.log('Series en tendencia:');
            this.seriesTranding = await getSeriesTrending(1);
            console.log('Series top:');
            this.topSeries = await getTopSeries(1,'ES');
            console.log('Series popularen en el momento:');
            this.popularSeries = await getSeries();
        },
        //Dependien de la pantalla se visualizan 5 o 6 peliculas y series
        changeSizeScreen(){
            var esPantallaGrande = window.matchMedia("(min-width: 990px)").matches
            if (esPantallaGrande)
                this.cantPelis = 5
            else
                this.cantPelis = 6
        },
        //Elimina el evente de cambio de pantalla
        removeResize(){
            window.removeEventListener("resize",this.changeSizeScreen)
        }
    },
    //Componentes que se usan para el Home
    components:{
        movieCard,
        serieCard
    },
    //Cuando se crea el componente añade el funcion de cambio de tamaño al evento resize
    created(){
        this.changeSizeScreen()
        window.addEventListener("resize",this.changeSizeScreen)
    },
    //Al irse a otro ruta diferente borra el evente de cambio de tamaño
    beforeRouteLeave(){
        this.removeResize()
    }
}
</script>

<style>
body{
    margin: 0;
    font-family: 'Poppins', sans-serif;
    color: #f8f8f8;    
}
.movies,.series{
    background-color: rgba(255, 255, 255, 0.1);
    border: #fff dashed 1px;
    border-radius: 5px;
    padding: 1rem;
    margin-bottom: 1rem;
    box-shadow: 0 0.46875rem 2.1875rem rgba(4,9,20,0.03),0 0.9375rem 1.40625rem rgba(4,9,20,0.03),0 0.25rem 0.53125rem rgba(4,9,20,0.05),0 0.125rem 0.1875rem rgba(4,9,20,0.03);
}
</style>