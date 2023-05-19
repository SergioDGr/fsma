import axios  from "axios";
import { API_KEY, API_URL } from '../../config/env.js' 


//Plantilla para hacer las consultas para API externa
async function query(url_pattern,page_index = 0,lang = '', reg = '',pattern = ''){
    let element = null
    await axios.get(API_URL + url_pattern,{
        params:{
            api_key: API_KEY,
            ...(page_index != 0 ? {page: page_index}:{}),
            ...(reg != '' ? {region: reg}:{}),
            ...(lang != '' ? {language: lang}:{}),
            ...(pattern != '' ? {query: pattern}:{})
        }
    }).then(response => {
        console.log(response.data);
        if (response.data.results != undefined){
            element = response.data.results
        }else 
            element = response.data
    }).catch(e =>{
        console.log(e);
    })
    return element;
}
//Consultas relacionadas películas
//Información de una película en concreto
export async function getMovie(id,lang){
    return await query('movie/'+id,0,lang)
}
//Información películas (ordenado por popular actualmente)
export async function getMovies(page = 1){
    return await query('discover/movie',page,'es-ES');
}

//Información de películas en tendencias de hoy
export async function getMoviesTrending(page = 1){
    return await query('trending/movie/day',page,'es-ES');
}

//Películas mejores valoradas
export async function getTopMovies(page = 1){
    return await query('movie/top_rated',page,'es-ES');
}

//Próximas películas
export async function getUpcomingMovies(page = 1,region){
    return await query('movie/upcoming',page,'es-ES',region);
}

//Recomendaciones de la película pasada por parámetro(id)
export async function getRecommendations(id,page = 1,region){
    return await query('movie/'+id+'/recommendations',page,'es-ES',region);
}

//Títulos alternativos de la película
export async function getAlterTitles(id){
    return await query('movie/'+id+'/alternative_titles');
}

//Las fechas de estrenos en diferentes regiones
export async function getRelease_date(id){
    let dates = []
    dates = await query('movie/'+id+'/release_dates')
    console.log(dates);
    let d = dates.filter(date => date.iso_3166_1 == 'ES')
    if(d.length == 0)
        return ''
    return d[0].release_dates[0].release_date
}

//Para sacar información de las series
//Sacar series por popularidad
export async function getSeries(page,region){
    return await query('discover/tv',page,'es-ES',region);
}
//Sacar series por mejores valoradas
export async function getTopSeries(page,region){
    return await query('tv/top_rated',page,'es-ES',region);
}
//Sacar series que están en tendencia actualmente
export async function getSeriesTrending(page = 1){
    return await query('trending/tv/day',page);
}
//Sacar información de una serie en concreto
export async function getSerie(id,lang){
    return await query('tv/'+id,0,lang)
}
//Conseguir recomendación de series
export async function getSerieRecommendations(id,page,region){
    return await query('tv/'+id+'/recommendations',page,'es-ES',region);
}

export async function getSerieImages(id){
    return await query('tv/'+id+'/images',0);
}
//Conseguir las temporadas y su información
export async function getSerieSeason(serie_id, season_id){
    return await query('/tv/'+serie_id+'/season/'+season_id,0,'es-ES');
}

//Metodos compartidos
//Conseguir el último tráiler
export async function getVideo(id,media){
    let videos = []
    videos = await query(media+'/'+id+'/videos',0,'es-ES');
    if (videos.length == 0)
            videos = await query(media+'/'+ id +'/videos')
    console.log(videos);
    let v = videos.filter(video => video.type == 'Trailer' && video.site =='YouTube') ;
    console.log(v);
    if(v.legth == 0)
        return null;
    return v[0];
}
//Conseguir los actores y los del staff
export async function getCredits(id,media){
    return await query(media+'/'+ id + '/credits')
}

//Para el componente Buscador
export async function  getSearchMovies(pattern,page = 1){
    return await query('/search/movie',page,'es-ES','',pattern)
}
export async function  getSearchSeries(pattern,page = 1){
    return await query('/search/tv',page,'es-ES','',pattern)
}