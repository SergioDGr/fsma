<template>
    <!--Si visualiza el buscador si lo utiliza-->
    <router-view :key="this.$route.path"></router-view>
    <!--Contendrá el contenido del componente-->
    <div class="app-body container">
        <div class="m-1">
            <div class="container p-0 ">
                <!--Titulo Serie-->
                <h1 v-if="serie.name != undefined" class="p-3 text-warning background-color text-uppercase">{{ serie.name }}</h1>
                <div class="row">
                    <!--Barra vertical-->
                    <div class="col-sm-4 col-md-3 col-lg-2 my-3">
                        <div class="background-color">
                            <!--Póster de la serie-->
                            <div v-if="serie.poster_path != null">
                                <img class="rounded m-0 " :src="base_img + serie.poster_path ">
                            </div>
                            <div class="m-2" v-if="this.$user.value!=null">
                                <select class="form-select" name="selectEstado">
                                    <option value="default" selected>No vista</option>
                                    <option value="watching">Viendo</option>
                                    <option value="watched">Vista</option>
                                    <option value="planned">Planeada</option>
                                    <option value="droppeed">Eliminada</option>
                                </select>
                            </div>
                            <!--Información de la Serie-->
                            <div>
                                <div class="serie-info"> 
                                    <!--Temporadas-->
                                    <div>
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Seasons')}}</h3>
                                        <span>{{ serie.number_of_seasons }}</span>
                                    </div>
                                    <!--Numero de episodios-->
                                    <div>
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Episodes')}}</h3>
                                        <span>{{ serie.number_of_episodes }}</span>
                                    </div>
                                    <!--El estado en el que esta la serie-->
                                    <div>
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Status')}}</h3>
                                        <span>{{ this.getStatus(serie.status) }}</span>
                                    </div>
                                    <!--La fecha que se emitió por primera vez-->
                                    <div v-if="serie.first_air_date != ''">
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Release_Date')}}</h3>
                                        <span>{{ serie.first_air_date }}</span>
                                    </div>
                                    <!--Ultimo emisión que se hizo-->
                                    <div v-if="serie.last_air_date != ''">
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Last_Air_Date')}}</h3>
                                        <span>{{ serie.last_air_date }}</span>
                                    </div>
                                    <!--Duración de los episodios-->
                                    <div v-if="serie.episode_run_time != 0">
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Run_Time') }}</h3>
                                        <div v-for="run_time in serie.episode_run_time " :key="run_time">
                                            {{ getHoursFormat(run_time) }}
                                        </div>
                                    </div>
                                    <!--Los generos que tiene la serie -->
                                    <div v-if="serie.genres != 0">
                                        <h3 class="fs-4 text-warning">{{$t('Serie.Genres')}}</h3>
                                        <div>
                                            <div v-for="genre in serie.genres" :key="genre.id">
                                                {{ genre.name }}
                                            </div>
                                        </div>
                                    </div>   
                                    <!--El nombre original de la serie si la hay-->
                                    <div v-if="serie.original_name != serie.name">
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Original_Title') }}</h3>
                                        <span>{{ serie.original_name }}</span>
                                    </div>
                                    <!--Las compañías que las producieron-->
                                    <div>
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Production_Companies') }}</h3>
                                        <div class="mt-2" v-for="company in serie.production_companies" :key="company">
                                            <span>{{ company.name }}</span>
                                        </div>
                                    </div>
                                    <!--Quien creo la serie-->
                                    <div v-if="serie.created_by != 0">
                                        <h3 class="fs-4 text-warning">{{ $t('Serie.Created_By') }}</h3>
                                        <div v-for="creator in serie.created_by" :key="creator.id">
                                            {{ creator.name }}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>    
                    </div>
                    <!--Contenido central-->
                    <div class="col p-0 ">
                        <!--Sinopsis de la Serie-->
                        <div v-if="serie.overview != ''" class="background-color my-3">
                            <h2 class="text-warning">{{ $t('Serie.Overview')}}</h2>
                            <hr class="mt-2">
                            <p class="m-1">{{ serie.overview }}</p>
                        </div>
                        <!--Cast y Crew-->
                        <div  class="background-color col my-3">
                            <!--Títulos-->
                            <h2 class="text-warning text-start">
                                <!--Botón que visualiza el Cast-->
                                <button @click="hiddenCrew" class="btn text-warning fs-3"> {{ $t('Serie.Cast')}}</button>
                                \
                                <!--Botón que visualiza el Crew-->
                                <button @click="crewVisible" class="btn text-warning fs-3">{{ $t('Serie.Crew')}}</button>
                            </h2>
                            <hr class="mt-0">
                            <!--El contenido del cast-->
                            <div v-if="!visibleCrew" class="row">
                                <!--Cast-->
                                <div class="col-md-6 col-lg-4 m-auto my-2" v-for="actor in cast.slice(0,this.cantVisibleCast)" :key="actor.id">
                                    <cast-card :name="actor.name" :character="actor.character" :profile_path="actor.profile_path" :image="base_img+actor.profile_path"></cast-card>
                                </div>
                                <!--Botón para visualizar mas-->
                                <div v-if="this.cantVisibleCast < cast.length && cast.length > 9">
                                    <button class="btn btn-warning mt-3"  @click="this.castShowMore">{{$t('Serie.Show_More')}}</button>
                                </div>
                                <!--Botón para visualizar menos-->
                                <div v-if="this.cantVisibleCast > 9 && this.cantVisibleCast >= cast.length">
                                    <button class="btn btn-warning mt-3"  @click="this.castDefaultShowed">{{$t('Serie.Show_Less')}}</button>
                                </div>
                            </div>
                            <!--EL contenido del crew-->
                            <div v-else class="row">
                                <!--Crews-->
                                <div class="col-md-6  col-lg-4 m-auto  my-2" v-for="crew in crews.slice(0,this.cantVisibleCrew)" :key="crew.id">
                                    <crew-card :name="crew.name" :job="crew.job" :profile_path="crew.profile_path" :known_for_department="crew.known_for_department" :image="base_img+crew.profile_path"></crew-card>
                                </div>
                                <!--Botón Para visualizar mas-->
                                <div v-if="this.cantVisibleCrew < crews.length && crews.length > 9">
                                    <button class="btn btn-warning mt-3"  @click="this.crewShowMore">{{$t('Serie.Show_More')}}</button>
                                </div>
                                <!--Botón Para visualizar menos-->
                                <div v-if="this.cantVisibleCrew > 9 && this.cantVisibleCrew >= crews.length">
                                    <button class="btn btn-warning mt-3"  @click="this.crewDefaultShowed">{{$t('Serie.Show_Less')}}</button>
                                </div>
                            </div>
                        </div>
                        <!--Temporadas-->
                        <div v-if="this.$user.value != null" class="background-color my-3">
                            <!--Encabezado-->
                            <h2  v-if="indexSeason == -1" class="text-warning text-start">{{ $t('Serie.Seasons') }}</h2>
                            <h2 v-else class="text-warning text-start" >
                                <a class="text-decoration-none" :href="'#seasons_'+indexSeason" @click="indexSeason = -1">{{ $t('Serie.Seasons') }}</a> / 
                               <span v-if="this.sameSeason"> {{seasons[indexSeason-1].name}}</span>
                               <span v-else> {{seasons[indexSeason].name}}</span>
                            </h2>
                            <hr>
                            <!--Temporadas que no continen contenido extra-->
                            <div v-if="indexSeason == -1 && this.sameSeason" class="row">
                                <div :class="{'col-md-6 col-lg-3 ': !this.temporadaVisible[idx]}" v-for="(season, idx) in seasons" :key="idx">
                                    <season :season="season" :idx="idx" :image="base_img+season.poster_path" :temporadaVisible="this.temporadaVisible[idx]" :visualizarInfoTemporada="visualizarInfoTemporada" :guardarIndexSeason="guardarIndexSeason"></season>
                                </div>
                            </div>
                            <!--Temporadas que continen contenido extra (No se visualiza)-->
                            <div  v-else-if="indexSeason == -1 " class="row">
                                <div :class="{'col-md-6 col-lg-3 ': !this.temporadaVisible[idx]}" v-for="(season, idx) in seasons.slice(1,this.serie.number_of_seasons+1)" :key="idx">
                                    <season :season="season" :idx="idx" :image="base_img+season.poster_path" :temporadaVisible="this.temporadaVisible[idx]" :visualizarInfoTemporada="visualizarInfoTemporada" :guardarIndexSeason="guardarIndexSeason"></season>
                                </div>
                            </div>
                            <!--Los episodios de la temporada-->
                            <div v-else class="row">
                                <div class="col-sm-6 col-md-4 col-lg-2" v-for="(episode,idx) in episodes[indexSeason].episodes" :key="idx">
                                    <img :src="base_img+episode.still_path" />
                                    <p class="m-0">{{ episode.name }}</p>
                                    <label class="form-check-label" for="episodes">Visto</label>
                                    <input class="form-check-input mx-2" type="checkbox" id="episodes" name="episodes" :value="episode.id">
                                </div>
                            </div>
                        </div>
                        <!--Tráiler-->
                        <div v-if="video != undefined && video != {}" class="background-color my-3 video embed-responsive embed-responsive-16by9 col-lg d-none d-lg-block ">
                            <h2 class="text-warning">{{ $t('Serie.Trailer')}}</h2>
                            <hr class="mt-0">
                            <iframe :id="this.video.id" :src="'https://www.youtube-nocookie.com/embed/'+video.key" title="YouTube video player" frameborder="0" allow=" web-share" allowfullscreen></iframe>
                        </div>
                       
                    </div>
                </div>
                <!--Recomendaciones-->
                <div v-if="recommendations != 0" class="background-color">
                    <h2 class="text-warning">{{ $t('Serie.Recommendations')}}</h2>
                    <div class="row justify-content-around">
                        <div class="card col-5 col-md-3 col-lg-2" v-for="(recommendation, idx) in recommendations.slice(0,5)" :key="idx">
                            <serie-card :id="recommendation.id" :title="recommendation.name" :image="base_img +recommendation.poster_path"></serie-card>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { getSerie, getSerieRecommendations, getVideo, getCredits, getSerieImages, getSerieSeason } from '../services/ApiService'
import { API_IMG_URL } from '../../config/env.js';
import SerieCard from './SerieCard.vue';
import CastCard from '../People/CastCard.vue'
import CrewCard from '../People/CrewCard.vue'
import Season from '../template/Season.vue';

export default {
    //Componentes que continen el componente
    components: { SerieCard, CastCard, CrewCard, Season },
    //Variables del componente
    data(){
        return{
            id: this.$route.params.id,
            serie: [],
            video: {},
            base_img: API_IMG_URL,
            recommendations: [],
            cast: [],
            crews: [],
            providers:[],
            seasons:[],
            episodes:[],
            sameSeason: true,
            images: [],
            cargando: true,
            visibleCrew: false,
            cantVisibleCrew: 9,
            cantVisibleCast: 9, 
            temporadaVisible: [],
            esta: false,
            visibleSeasonEpisodes: [],
            indexSeason: -1
        }
    },
    //Metodos
    methods:{
        //Para conseguir la informacion de la Api
        async getData(){
            if(this.cargando){
                console.log("Serie:");
                this.serie = await getSerie(this.id,'es-ES');
                console.log("Recomendaciones:");
                this.recommendations = await getSerieRecommendations(this.id,1,'es-ES')
                console.log("Video:");
                this.video = await getVideo(this.id,'tv');
                console.log("Fechas de Estreno: ");
                this.serie.first_air_date = this.getDateFormat(this.serie.first_air_date);
                this.serie.last_air_date = this.getDateFormat(this.serie.last_air_date);
                console.log("Cast y Crew:");
                let credits = await getCredits(this.id,'tv');
                this.cast = credits.cast
                console.log(this.cast);
                this.crews = credits.crew
                console.log( this.crews);
                console.log("Temporadas: ");
                this.seasons = this.serie.seasons
                console.log(this.seasons);
                this.sameSeason =  this.seasons.length == this.serie.number_of_seasons
                let cantSeason = this.serie.number_of_seasons
                let i = 0;
                if(!this.sameSeason)
                    cantSeason +1;
                else
                    i = 1;
                for(;i<=cantSeason;i++){
                    this.temporadaVisible[i]=false;
                    console.log('Temporada '+i+": ");
                    this.episodes[i] = await getSerieSeason(this.serie.id,i);
                    this.visibleSeasonEpisodes[i] = false;
                }
                console.log(this.sameSeason);
                this.images = await getSerieImages(this.id);
                console.log(this.images);
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
            if(!isNaN(hours) && !isNaN(mins)){
                let str = hours != 0? hours +" h" : "";
                str += mins != 0? mins + " min": "";
                return str;
            }else
                return this.$t('Serie.not_found');
        },
        //Se visualize vien el estado dependiendo del idioma
        getStatus(status){
            switch (status) {
                case 'Returning Series':
                    return this.$t('Serie.Status_Mode[0]')
                case 'Planned':
                    return this.$t('Serie.Status_Mode[1]')
                case 'In Production':
                    return this.$t('Serie.Status_Mode[2]')
                case 'Ended':
                    return this.$t('Serie.Status_Mode[3]')
                case 'Cancelled':
                    return this.$t('Serie.Status_Mode[4]')
                case 'Pilot':
                    return this.$t('Serie.Status_Mode[5]')
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
            console.log(this.cantVisibleCrew);
        },
        //Mostrar la cantidad por defecto
        crewDefaultShowed(){
            this.cantVisibleCrew = 9 
        },
        //Mostrar mas Cast
        castShowMore(){
            this.cantVisibleCast += 9 
        },
        //Mostrar la cantidad por defecto
        castDefaultShowed(){
            this.cantVisibleCast = 9 
        },
        guardarIndexSeason(index){
            this.indexSeason = index
        },
        visualizarInfoTemporada(idx){
            console.log(idx+ " 1asda");
            this.temporadaVisible[idx] = !this.temporadaVisible[idx]
        }
    },
    //Anter que se monte el componente
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
.serie-info>div{
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