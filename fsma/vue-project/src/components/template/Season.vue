<template>
    <!--La temporada-->
    <div class="row my-3">
        <!--Se visualiza la poster y el titulo de la temporada-->
        <div :class="{'col-md-6 col-lg-3 ': this.temporadaVisible}">
            <a @click="visualizar">
                <div>
                    <img v-if="season.poster_path != null" :src="image" :alt="season.name">
                    <img v-else :src="image_default" alt="default_image">
                </div>
                <h4>{{ season.name }}</h4>
            </a>
        </div>
        <!--Al darle click al boton visualiza informacion de la pelicula-->
        <div class="col-9" v-if="this.temporadaVisible">
            <p class="text-start"><b>{{ $t('Season.Release_Date') }}</b>: {{ season.air_date }}</p>
            <p class="text-start" v-if="season.overview != ''"><b>{{ $t('Season.Overview') }}</b>: {{ season.overview }}</p>
            <p class="text-start"><b>{{ $t('Season.Episode_Count') }}</b>: {{ season.episode_count }}</p>
            <p class="text-start">
                <a @click="guardarIndex" class="btn btn-warning">{{ $t('Season.View_Episodes') }}</a>
            </p>
        </div>  
    </div>
</template>

<script>
export default{
    //Parametro que se les pasa
    props:{
        season: {},
        image: String,
        idx: Number,
        temporadaVisible: Boolean,
        visualizarInfoTemporada: {
            type: Function
        },
        guardarIndexSeason:{
            type: Function
        }
    },
    methods:{
        //Para visualizar Informacio para la temporada
        visualizar(){
            if(this.visualizarInfoTemporada){
                this.visualizarInfoTemporada(this.idx);
            }
        },
        //Guarda el indice y al hacerlo visualiza los episodios
        guardarIndex(){
            if(this.guardarIndexSeason){
                this.guardarIndexSeason(this.idx+1);
            }
        }
    },
    data(){
       return { image_default: './images/default_image.png'}
    }
 }
</script>