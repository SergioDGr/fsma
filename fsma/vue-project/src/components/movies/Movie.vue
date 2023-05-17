<template>
    <!-- Si visualiza el buscador si lo utiliza-->
    <router-view :key="this.$route.path"></router-view>
    <!--Contendra el contenido del componente-->
    <div class="app-body container">
        <div class="m-1">
            <div class="container p-0 ">
                <!--Titulo Pelicula-->
                <h1 class="p-3 text-warning background-color text-uppercase">{{ movie.title }}</h1>
                <div class="row">
                    <!--Barra vertical-->
                    <div class="col-4 col-md-3 col-lg-2">
                        <div  class="background-color">
                            <!-- Poster de la pelicula-->
                            <div v-if="movie.poster_path != null">
                                <img class="rounded m-0 " :src="base_img + movie.poster_path ">
                            </div>
                            <div class="m-2" v-if="this.$user.value!=null">
                                <select class="form-select" name="selectEstado">
                                    <option value="default" selected>No vista</option>
                                    <option value="watched">Vista</option>
                                    <option value="planned">Planeada</option>
                                    <option value="droppeed">Eliminada</option>
                                </select>
                            </div>
                            <!-- Informacion de la pelicula -->
                            <div>
                                <div class="movie-info">
                                    <!--Fecha de estreno--> 
                                    <div v-if="movie.release_date != ''">
                                        <h3 class="fs-4 text-warning">{{ $t('Movie.Release_Date') }}</h3>
                                        <!-- Se mostrara la fecha de estreno por defecto si la de la region no tiene valor -->
                                        <span v-if="this.fecha_region == ''">{{ movie.release_date }}</span>
                                        <span v-else>{{ this.fecha_region }}</span>
                                    </div>
                                    <!--La duracion de la pelicula-->
                                    <div v-if="movie.runtime != 0">
                                        <h3 class="fs-4 text-warning">{{ $t('Movie.Run_Time')}}</h3>
                                        <span>{{ getHoursFormat(movie.runtime) }}</span>
                                    </div>
                                    <!--Generos de las peliculas-->
                                    <div v-if="movie.genres != 0">
                                        <h3 class="fs-4 text-warning">{{$t('Movie.Genres')}}</h3>
                                        <div>
                                            <div v-for="genre in movie.genres" :key="genre.id">
                                                <span>{{ genre.name }}</span>
                                            </div>
                                        </div>
                                    </div>   
                                    <!-- Estado de la pelicula -->
                                    <div>
                                        <h3 class="fs-4 text-warning">{{$t('Movie.Status')}}</h3>
                                        <span>{{ getStatus(movie.status) }}</span>
                                    </div>
                                    <!--Titulo Original-->
                                    <div v-if="movie.original_title != movie.title">
                                        <h3 class="fs-4 text-warning">{{$t('Movie.Original_Title')}}</h3>
                                        <span>{{ movie.original_title }}</span>
                                    </div>
                                    <!-- Si hay mas de una fecha de estreno(Depende de la region)-->
                                    <div  v-if="this.fecha_region != ''">
                                        <h3 class="fs-4 text-warning">{{ $t('Movie.Original_Release_Date') }}</h3>
                                        <span>{{ movie.release_date }}</span>
                                    </div>
                                    <!--Las compañias que las produccieron-->
                                    <div>
                                        <h3 class="fs-4 text-warning">{{ $t('Movie.Production_Companies') }}</h3>
                                        <div v-for="company in movie.production_companies" :key="company">
                                            {{ company.name }}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Contenido central-->
                    <div class="col p-0">
                        <!--Sinopsis de la Pelicula-->
                        <div v-if="movie.overview != ''" class="background-color">
                            <h2 class="text-warning">{{$t('Movie.Overview')}}</h2>
                            <hr class="mt-2">
                            <p class="m-1">{{ movie.overview }}</p>
                        </div>
                        <!--Cast y Crew-->
                        <div class="background-color col">
                            <!--Titulos-->
                            <h2 class="text-warning text-start">
                                <!--Boton que visualiza el Cast-->
                                <button @click="hiddenCrew" class="btn text-warning fs-3">{{ $t('Movie.Cast')}}</button>
                                \
                                <!--Boton que visualiza el Crew-->
                                <button @click="crewVisible" class="btn text-warning fs-3">{{ $t('Movie.Crew')}}</button>
                            </h2>
                            <hr class="mt-0">
                            <!--EL contenido del cast-->
                            <div v-if="!visibleCrew" class="row">
                                <!--Cast-->
                                <div class="col-md-4 m-auto" v-for="actor in cast.slice(0,this.cantVisibleCast)" :key="actor.id">
                                    <cast-card :name="actor.name" :character="actor.character" :profile_path="actor.profile_path" :image="base_img+actor.profile_path"></cast-card>
                                </div>
                                <!--Boton Para visualizar mas-->
                                <div v-if="this.cantVisibleCast < cast.length && cast.length > 9">
                                    <button class="btn btn-warning mt-3" @click="this.castShowMore">{{$t('Movie.Show_More')}}</button>
                                </div>
                                <!--Boton Para visualizar menos-->
                                <div v-if="this.cantVisibleCast > 9 && this.cantVisibleCast >= cast.length">
                                    <button class="btn btn-warning mt-3" @click="this.castDefaultShowed">{{$t('Movie.Show_Less')}}</button>
                                </div>
                            </div>
                            <!--EL contenido del crew-->
                            <div v-else class="row">
                                <!--Crews-->
                                <div class="col-md-4 m-auto" v-for="crew in crews.slice(0,this.cantVisibleCrew)" :key="crew.id">
                                    <crew-card :name="crew.name" :job="crew.job" :profile_path="crew.profile_path" :known_for_department="crew.known_for_department" :image="base_img+crew.profile_path"></crew-card>
                                </div>
                                <!--Boton Para visualizar mas-->
                                <div v-if="this.cantVisibleCrew < crews.length && crews.length > 9">
                                    <button class="btn btn-warning mt-3" @click="this.crewShowMore">{{$t('Movie.Show_More')}}</button>
                                </div>
                                <!--Boton Para visualizar menos-->
                                <div v-if="this.cantVisibleCrew > 9 && this.cantVisibleCrew >= crews.length">
                                    <button class="btn btn-warning mt-3" @click="this.crewDefaultShowed">{{$t('Movie.Show_Less')}}</button>
                                </div>
                            </div>
                        </div>
                        <!--Trailer-->
                        <div v-if="video != undefined" class="background-color video embed-responsive embed-responsive-16by9 col-lg d-none d-md-block">
                            <h2 class="text-warning">{{$t('Movie.Trailer')}}</h2>
                            <hr class="mt-0">
                            <iframe :id=" video.id " :src="'https://www.youtube-nocookie.com/embed/'+video.key" title="YouTube video player" frameborder="0" allow=" web-share" allowfullscreen></iframe>
                        </div>
                    </div>
                </div>
                <!--Recomendaciones-->
                <div v-if="recommendations != 0" class="background-color">
                    <h2 class="text-warning">{{$t('Movie.Recommendations')}}</h2>
                    <div class="row justify-content-around">
                        <div class="card col-5 col-md-3 col-lg-2" v-for="(recommendation, idx) in recommendations.slice(0,5)" :key="idx">
                            <movie-card :id="recommendation.id" :title="recommendation.title" :image="base_img +recommendation.poster_path"></movie-card>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { getMovie, getRecommendations, getVideo, getRelease_date, getCredits } from '../services/ApiService'
import { API_IMG_URL } from '../../config/env.js';
import MovieCard from './MovieCard.vue';
import CastCard from '../People/CastCard.vue'
import CrewCard from '../People/CrewCard.vue';

export default {
    //Componentes que continen el componente
    components: { MovieCard, CastCard, CrewCard },
    //Variables del componente
    data(){
        return{
            id: this.$route.params.id,
            movie: [],
            video: {},
            base_img: API_IMG_URL,
            recommendations: [],
            fecha_region: '',
            cast: [],
            crews: [],
            providers:[],
            cargando: true,
            visibleCrew: false,
            cantVisibleCrew: 9,
            cantVisibleCast: 9
        }
    },
    //Metodos
    methods:{
        //Para conseguir la informacion de la Api
        async getData(){
            if(this.cargando){
                console.log("Pelicula: ");
                this.movie = await getMovie(this.id,'es-ES');
                console.log("Recomendaciones: ");
                this.recommendations = await getRecommendations(this.id,1,'es-ES')
                console.log("Trailer:");
                this.video = await getVideo(this.id,'movie');
                console.log("Fecha de estreno en la region: ");
                this.fecha_region = await getRelease_date(this.id)
                console.log(this.fecha_region);
                if(this.fecha_region != '')
                    this.fecha_region = this.getDateFormat(this.fecha_region);
                console.log("Fecha de estreno original:");
                console.log(this.movie.release_date );
                let release_date = this.getDateFormat(this.movie.release_date);
                console.log(release_date);
                if (release_date != undefined &&  this.fecha_region.includes(release_date)){
                    this.fecha_region = ''
                }else
                    console.log(release_date);
                this.movie.release_date = release_date;
                console.log("Cast y Crew:");
                let credits = await getCredits(this.id,'movie');
                this.cast = credits.cast
                console.log(this.cast);
                this.crews = credits.crew
                console.log(this.crew);
                this.cargando = false
            }
        },
        //Para dar formato a la fecha
        getDateFormat(date){
            var date_format = new Date(date);
            console.log(date_format);
            var date_string = date_format.toLocaleDateString('es-ES');
            console.log(date_string);
            var date_array = date_string.split('/')
            var day = date_array[0] < 10 ? "0"+date_array[0]:date_array[0];
            var month = date_array[1] < 10 ? "0"+date_array[1]:date_array[1];
            return day +"/"+ month+ "/"+date_array[2];
        },
        //Para darle formato de hora minutos
        getHoursFormat(mins_total){
            var hours = Math.floor(mins_total /60);
            var mins = mins_total % 60;
            return hours + " h " + mins + " min"
        },
        //Se visualize vien el estado dependiendo del idioma
        getStatus(status){
            switch (status) {
                case 'Rumored':
                    return this.$t('Movie.Status_Mode[0]')
                case 'Planned':
                    return this.$t('Movie.Status_Mode[1]')
                case 'In Production':
                    return this.$t('Movie.Status_Mode[2]')
                case 'Post Production':
                    return this.$t('Movie.Status_Mode[3]')
                case 'Released':
                    return this.$t('Movie.Status_Mode[4]')
                case 'Cancelled':
                    return this.$t('Movie.Status_Mode[5]')
            }
        },
        //Visualizar Crew y ocultar cast
        crewVisible(){
            this.visibleCrew = true
            this.cantVisibleCast = 9
        },
        //Ocultar Crew y mostrar cast
        hiddenCrew(){
            this.visibleCrew = false
            this.cantVisibleCrew = 9 
        },
        //Mostrar mas Crew
        crewShowMore(){
            this.cantVisibleCrew += 9 
        },
        //Mostrar la cantidad por defecto
        crewDefaultShowed(){
            this.cantVisibleCrew = 9 
        },
        //Mostrar mas Cast
        castShowMore(){
            this.cantVisibleCast += 9 
        },
        castDefaultShowed(){
            this.cantVisibleCast = 9 
        }
    },
    async beforeMount(){
        window.scrollTo(0,0)
        await this.getData()
    }
}
</script>

<style>
.background-color{
    background-color: rgba(255, 255, 255, 0.1);
    margin: 1%;
    padding: 1%;
    border: 1px solid #fff;
    text-align: center;
    box-shadow: 0 0.46875rem 2.1875rem rgba(255, 255, 255, 0.03),0 0.9375rem 1.40625rem rgba(255, 255, 255, 0.03),0 0.25rem 0.53125rem rgba(255, 255, 255, 0.05),0 0.125rem 0.1875rem rgba(255, 255, 255, 0.03);
    border-radius: 7px;
}
.movie-info>div{
    margin: 1rem 0 ;
}
iframe{
    width: 80%;
    height: 30rem;
}
.nombres{
    color: #0a0a0a;
}
</style>