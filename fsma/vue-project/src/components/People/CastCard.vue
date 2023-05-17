<!--Componente que se añade a otros para la visualizacion de cada Actor-->
<template>
    <div class="card flex-row">
        <!--Perfil-->
        <div class="col-3 align-self-center">
            <img v-if="profile_path" class="rounded" :src="image" />
            <img v-else class="rounded " :src="image_default" />
        </div>
        <!--Nombre del actor y Pesonar que interpreta-->
        <div class="card-body">
            <div class="nombres my-1">
                <p class="mb-1"><strong>{{ character }}</strong></p>
                <p class="mb-1"><em>{{ name }}</em></p>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    //Parametros que se pasan
    props:{
        name: String,
        character: String,
        profile_path: String,
        image: String
    },
    data(){
        return {image_default: './images/default_image_actor.png'};
    }
}
</script>