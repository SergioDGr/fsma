<!--Barra del buscador-->
<template>
    <div class="d-flex justify-content-center">
        <input class="rounded-2 m-2 col-lg" name='buscar' type="text" v-model="searchQuery" v-on:keydown.enter="upEnter" :placeholder="$t('SearchBar')" @focusin="siFocus" @focusout="noFocus" autocomplete="off"/>
        <button class="fondoLupa border border-0">
            <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-search text-white" viewBox="0 0 16 16">
                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
            </svg>
        </button>
    </div>
</template>

<script>
export default {
    //Guarda la ruta
    props:{
        routeName: String
    },data(){
        return{
            searchQuery: '',
            count: 0,
            cambios: false,
            nameToGo: '',
            queryAnterior: null
        }
    //Metodos
    },methods:{
        //Cuando la busqueda cambia
        buscadorChange(){
            if (this.cambios){
                this.count = 0
                this.cambios = false
            }
        },
        //Cuando le dan al enter
        upEnter(){
            this.cambios = true
        },
        //Cuando la ruta cambia
         changeRoute(){
            if(this.searchQuery != this.queryAnterior){
                this.$router.push({ name:this.nameToGo, params:{ query: this.searchQuery}});
                this.count--;
            }
            this.queryAnterior = this.searchQuery
        },
        //Si el input esta en el foco
        siFocus(){
            this.$SearchBarVisible.value = true
            if(this.searchQuery != ''){
                this.$router.push({ name:this.nameToGo, params:{ query: this.searchQuery}});
                this.count--;
            }
        },
        //Si le quitan el foco al buscador
        noFocus(){
            console.log(this.$SearchVisible.value)
            this.$SearchBarVisible.value = false
            if(!this.$SearchBarVisible.value && !this.$SearchVisible.value){
                let meta = this.$route.meta;
                this.$router.push({ name: meta.parent })
            }
        }
    },
    //Cada vez que actualiza el componente Comprueba ene el buscador si hay algo escrito
    //Y despues visualiza el contenido llendo a la ruta
     updated(){
        if(this.searchQuery != ''){
             this.changeRoute();
        }else{
            if (this.count != 0){
                this.$router.go(this.count);
                this.count = 0
                this.queryAnterior = null
            }
        }
    },
    //Antes de que se actualiza el componente comprueta la ruta
    beforeUpdate(){
        if(this.routeName == 'Home'){
            this.count = 0
            this.nameToGo = 'SearchInMain'
        }else if(this.routeName == 'Movies'){
            this.count = 0
            this.nameToGo = 'SearchInMovies'
        }else if(this.routeName == 'Movie'){
            this.count = 0
            this.nameToGo = 'SearchInMovie'
        }else if(this.routeName == 'Series'){
            this.count = 0
            this.nameToGo = 'SearchInSeries'
        }else if(this.routeName == 'Serie'){
            this.count = 0
            this.nameToGo = 'SearchInSerie'
        }
    }
}
</script>


<style>
.fondoLupa{
    background: rgb(24, 24, 24);
}
</style>