/* Para configurar el enrutado para las páginas */
import { createRouter, createWebHistory } from "vue-router";
//Los componentes para las rutas
import Home from './components/home/Home.vue'
import Search from './components/search/search.vue'
import ViewMovies from './components/movies/viewMovies.vue'
import Movie from './components/movies/Movie.vue'
import Series from './components/series/viewSeries.vue'
import Serie from './components/series/Serie.vue'
import Login from './components/auth/login.vue'
import Register from './components/auth/register.vue'
//Los enrutamientos y los componentes que se visualizan
const routes = [
  { path: '/', component: Home , name:'Home',children:[
    { path:'search/:query', name:'SearchInMain', component: Search, meta: { parent: 'Home'}},
  ]},
  { path: '/movie', component: ViewMovies, name:'Movies', children:[
    { path:'search/:query', name:'SearchInMovies', component: Search, meta: { parent: 'Movies'}},
  ]},
  { path:'/movie/:id', name:'Movie', component: Movie, children:[
    { path:'search/:query', name:'SearchInMovie', component: Search, meta: { parent: 'Movie'}},
  ]},
  { path:'/movie/trending', name:'Movie_Tranding', component: ViewMovies, children:[
    { path:'search/:query', name:'SearchInMovieTranding', component: Search, meta: { parent: 'Movie_Tranding'}},
  ]},
  { path:'/movie/top', name:'Movie_Most_Rated', component: ViewMovies, children:[
    { path:'search/:query', name:'SearchInMovieTop', component: Search, meta: { parent: 'Movie_Most_Rated'}},
  ]},
  { path:'/movie/upcoming', name:'Movie_upcoming', component: ViewMovies, children:[
    { path:'search/:query', name:'SearchInMovieUpcoming', component: Search, meta: { parent: 'Movie_upcoming'}},
  ]},
  { path: '/serie', name:'Series', component: Series, children:[
    { path:'search/:query', name:'SearchInSeries', component: Search, meta: { parent: 'Series'}}
  ]},
  { path:'/serie/trending', name:'Serie_Tranding', component: Series, children:[
    { path:'search/:query', name:'SearchInSeriesTranding', component: Search, meta: { parent: 'Series_Tranding'}}
  ]},
  { path:'/serie/top', name:'Serie_Most_Rated', component: Series, children:[
    { path:'search/:query', name:'SearchInSeriesTop', component: Search, meta: { parent: 'Series_Top'}}
  ]},
  { path:'/serie/:id', name:'Serie', component: Serie, children:[
    { path:'search/:query', name:'SearchInSerie', component: Search},
  ]},
  { path:'/login', name:'Login', component: Login },
  { path:'/register', name:'Register', component: Register},
  { path: '/:pathMatch(.*)*', redirect: '/'}
];
//Crea el histórico
const history = createWebHistory();
//Crea el router
const router = createRouter({
  history,
  routes,
});

export default router;