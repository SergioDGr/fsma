<!--Componente que se visualiza cuando se le hace una busqueda-->
<template>
    <!--Es visible el componente cuando se busca y siempre que este el mouse encima-->
    <div v-if="this.$SearchVisible.value || this.$SearchBarVisible.value"  class="top-10 position-fixed bg-dark front-show end-0 w-100 pt-4 pb-3" v-on:mouseleave="mouseLeave" v-on:mouseenter="mouseEnter">
        <div id="search" class="container">
            <!--Cuando se esta cargando-->
            <div v-if="cargando" class="text-center fw-bold fs-4">
                {{ $t('Search.Searching') }}
            </div>
            <!--Las busquedas para las peliculas-->
            <div v-if="!cargando && pelisPattern != 0">
                <h4 class="m-0 text-center fw-bold text-info">{{$t('Search.Movies')}}</h4>
                <hr class="mt-2 mb-2">
                
                <div class="arrayas" v-for="movie in pelisPattern.slice(0,10)" :key="movie">
                    <router-link class="m-1 link " :to="{ name:'Movie',params:{id: movie.id} }" >
                    <span class=""> {{ movie.title }}</span>
                    </router-link>
                </div>
            </div>
            
            <hr class="mt-2 mb-2" v-if="!cargando && seriesPattern != 0">
            <!--Busquedas para Series-->
            <div v-if="!cargando && seriesPattern != 0">
                <h4 class="m-0 text-center fw-bold text-info">{{$t('Search.Series')}}</h4>
                <hr class="mt-2 mb-2">

                <div class="arrayas" v-for="serie in seriesPattern.slice(0,10)" :key="serie">
                    <router-link class="m-1 link " :to="{ name:'Serie',params:{id: serie.id} }" >
                    <span class=""> {{ serie.name }}</span>
                    </router-link>
                </div>
            </div>
            <!--Cuando no se encuetra nada-->
            <div v-if="pelisPattern.length == 0 && seriesPattern.length == 0 && cargando == false" class="text-center fw-bold text-danger">
                {{$t('Search.Not_Found')}}
            </div>
            <hr class="mt-1">
            <div  v-if="pelisPattern.length > 10 || seriesPattern.length > 10" class="row" >
                 <button class="btn btn-light rounded">
                    <div class="d-flex justify-content-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="text-primary bi bi-plus-circle-fill my-auto p-1" viewBox="0 0 16 16">
                            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/>
                        </svg>
                        <h5 class="text-center text-primary fw-bold my-auto">{{$t('Search.Show')}}</h5>
                    </div>
                </button>
            </div>
        </div>
        <div>
            
        </div>
    </div>
    
</template>

<script>
import { getSearchMovies,getSearchSeries } from '../services/ApiService'
export default{
    data(){
        return{
            query: this.$route.params.query,
            pelisPattern: [],
            seriesPattern: [],
            cargando: false
        }
    },
    methods:{
        //guarda los datos de las series y pelis
        async loadMedia(){
            this.cargando = true
            console.log('Movies');
            this.pelisPattern = await getSearchMovies(this.query);
            console.log('Series');
            this.seriesPattern = await getSearchSeries(this.query);
            this.cargando = false
        },
        //Cuando el raton sale del componente se oculta
        mouseLeave(){
            this.$SearchVisible.value = false
            if(!this.$SearchBarVisible.value && !this.$SearchVisible.value){
                let meta = this.$route.meta;
                this.$router.push({ name: meta.parent })
            }
        },
        //Cuando en raton esta dentro del componente se visualiza
        mouseEnter(){
            this.$SearchVisible.value = true
        }
    },
    
    //Antes de montar el componende carga los datos
    async beforeMount(){
        console.log("Buscando:");
        await this.loadMedia();
    },
    //Antes de que cambie la routa lo guarda
    beforeRouteUpdate(to,from,next){
        this.query = to.params.query;
        next();
    },
    //Cuando se crea se visualiza el elemento buscador
    created(){
        this.$SearchVisible.value = true
    }
}
</script>

<style>
.front-show{
    z-index: 10;
    opacity: 0.95;
    
}
@media (min-width: 990px) {
    .w-100{
        width: 25% !important;
    }
}
span{
    color: white;
}
.arrayas:nth-child(even) span {
    color: orange;
}

.link{
    text-decoration: none;
}
.top-10{
    top:4.5rem !important
}
</style>