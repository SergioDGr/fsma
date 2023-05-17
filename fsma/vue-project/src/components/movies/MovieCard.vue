<!--Componente que se añade a otros para la visualizacion de las peliculas-->
<template>
    <!--Imagen-->
    <router-link :to="{ name:'Movie',params:{id: id} }" >
        <img v-if="!image.includes('/w500null')" class="rounded" :src="image" />
        <img v-else class="rounded" src="../../../public/images/default_image.png" />
    </router-link>
    <!--Titulo-->
    <div class="card-body p-0 d-flex flex-column justify-content-around ">
        <router-link class="link" :to="{ name:'Movie',params:{id: id} }" :key="id" >
            <h5 class="card-title text-center "><b>{{ title }}</b></h5>
        </router-link>
    </div>
</template>

<script>
export default {
    //Parametros que se pasan
    props:{
        id: Number,
        image: String,
        title: String,
    }
}
</script>

<style>
.link{
    text-decoration: none;
    color: #111111;
}
.link:hover{
    color: #111111;
}
.hide{
    display: none;
}
</style>