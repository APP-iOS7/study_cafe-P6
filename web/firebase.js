import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyA-ztBVtA18Uy6naYg4XVgsDJgRsAegsw8",
    authDomain: "studycafe-p6.firebaseapp.com",
    projectId: "studycafe-p6",
    storageBucket: "studycafe-p6.firebasestorage.app",
    messagingSenderId: "664297103546",
    appId: "1:664297103546:web:438d5e40d9005e7ac9e283",
    measurementId: "G-R8K8E1J33P"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);