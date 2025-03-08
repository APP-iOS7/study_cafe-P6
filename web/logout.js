// Firebase 모듈 가져오기
import { initializeApp } from "https://www.gstatic.com/firebasejs/11.4.0/firebase-app.js";
import { getAuth, signOut, onAuthStateChanged } from "https://www.gstatic.com/firebasejs/11.4.0/firebase-auth.js";
import { getFirestore, collection, getDocs } from "https://www.gstatic.com/firebasejs/11.4.0/firebase-firestore.js";

// Firebase 구성
const firebaseConfig = {
    apiKey: "AIzaSyA-ztBVtA18Uy6naYg4XVgsDJgRsAegsw8",
    authDomain: "studycafe-p6.firebaseapp.com",
    projectId: "studycafe-p6",
    storageBucket: "studycafe-p6.firebasestorage.app",
    messagingSenderId: "664297103546",
    appId: "1:664297103546:web:438d5e40d9005e7ac9e283",
    measurementId: "G-R8K8E1J33P"
};

// Firebase 초기화
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);
console.log('Firebase 초기화 완료:', app.name);
console.log('Firebase 초기화 완료:', app.name);
console.log('Auth 객체 생성:', auth);

// displayName 표시 
const admin = document.getElementById('admin');
const userDataList = document.getElementById('reserveData');

onAuthStateChanged(auth, async (user) => {
    if (user) {
        const displayName = user.displayName || "이름 없음";
        console.log('현재 사용자 DisplayName:', displayName);
        admin.textContent = `환영합니다 ${displayName}님`;

        // Firestore에서 예약 데이터 가져오기 
        try {
            const querySnapshot = await getDocs(collection(db, "users")); // 로그인한 사용자의 UID 문서 조회 
            userDataList.innerHTML = ""; // 기존 내용 초기화
            querySnapshot.forEach((doc) => {
                const userData = doc.data();
                console.log('사용자 데이터:', userData);
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td> ${userData.username || "없음"}</td>
                    <td> ${userData.email || "없음"}</td>
                    <td>없음</td>
                `;
                userDataList.appendChild(tr);
            })
            if (querySnapshot.empty) {
                userDataList.innerHTML = "<li>사용자 데이터가 없습니다.</li>";
            }
        } catch (error) {
            console.error('사용자 데이터 가져오기 실패:', error.mesage);
            userDataList.innerHTML = `<li>데이터 가져오기 실패: ${error.message}</li>`;
        }
    } else {
        console.log('로그인 되지 않음');
        window.location.href = "index.html";
    }
});

// 로그아웃 이벤트
const logoutButton = document.getElementById('logoutButton');
logoutButton.addEventListener("click", async function (event) {
    event.preventDefault();

    try {
        await signOut(auth);
        alert("로그아웃 성공");
        window.location.href = "index.html";
    } catch (error) {
        console.error('로그아웃 실패:', error.message);
        alert("로그아웃 실패: " + error.message);
    }
});