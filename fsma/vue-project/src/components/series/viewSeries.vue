<!--El componente donde se muestran las series-->
<template>
    <!--Para visualizar el componente buscador-->
    <router-view :key="this.$route.path"></router-view>
    <!--Donde estas las Series-->
    <div class="app-body container">
        <!--Titulo-->
        <h1 class="text-center">{{$t('Series.Title')}}</h1>
        <div class="row justify-content-center movies">
            <div class="card col-5 col-md-3 col-lg-2" v-for="serie in series" :key="serie.id">
                <serie-card :id="serie.id" :image="base_img+serie.poster_path" :title="serie.name"></serie-card>
            </div>
        </div>
    </div>
</template>

<script>
import { getSeries, getSeriesTrending , getTopSeries } from "../services/ApiService";
import { API_IMG_URL } from '../../config/env.js';
import serieCard from './SerieCard.vue';

export default {
    //Variables
    data(){
        return{
            series: [],
            base_img: API_IMG_URL,
            page: 1,
            seriesGuardadas: false
        }
    },
    //Metodos
    methods:{
        //Conseguir los datos de las series
        async getData(newSeries = []){
            console.log("peticion numero: " + this.page);
            console.log(this.$route.name);
            let name_route = this.$route.name 
            if (this.series.length != 0){
                newSeries = await this.getSeriesFor(name_route)
                this.series.push(...newSeries)
            }else{
                this.series = await this.getSeriesFor(name_route)
            }
            console.log(this.series);
            this.page++;
            this.seriesGuardadas = false;
        },
        //Método que añade al evento scroll la función scroll
        getNextSeries(){
            window.addEventListener('scroll',this.scroll, false)
        },
        //Al scrollear hasta el final pedirá mas para añadir series
        scroll(){
            let bottomOfWindow = document.documentElement.scrollTop + window.innerHeight === document.documentElement.scrollHeight;        
            if (bottomOfWindow && this.seriesGuardadas == false) {
                this.getData()
                this.seriesGuardadas = true;
            }
        },
        //Elimina el evento que hay en el scroll
        removeScrollEvent(){
            window.removeEventListener('scroll', this.scroll, false);
            console.log('Desmontado')
        },
        //Dependiendo de la ruta da unas series o otras
        async getSeriesFor(pattern){
            switch (pattern) {
                case 'Serie_Most_Rated':
                    return await getTopSeries(this.page,'ES')
                case 'Serie_Tranding':
                    return await getSeriesTrending(this.page)
                default:
                    return await getSeries(this.page,'ES')
            }
        }
    },
    //Antes de montar añadir evento de scroll y inicializar el array de series
    async beforeMount(){
        this.getNextSeries();
        await this.getData()
    },
    //Componentes que se utilizan
    components:{
        serieCard
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