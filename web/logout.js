// Firebase 모듈 가져오기
import { initializeApp } from "https://www.gstatic.com/firebasejs/11.4.0/firebase-app.js";
import { getAuth, signOut, onAuthStateChanged } from "https://www.gstatic.com/firebasejs/11.4.0/firebase-auth.js";
import { getFirestore, getDoc, doc, collection, getDocs } from "https://www.gstatic.com/firebasejs/11.4.0/firebase-firestore.js";

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

const admin = document.getElementById('admin');
const userDataList = document.getElementById('reserveData');


// Firebase 초기화
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);

// 가격 정보 포맷팅 함수 
const formatPrice = (price) => {
    if (price == null || price === '') return '없음';

    // 숫자가 아닌경우 변환시도 
    const numPrice = Number(price);
    if (isNaN(numPrice)) return price;

    // 천단위 쉼표 추가 
    return new Intl.NumberFormat('ko-KR', {
        style: 'currency',
        currency: 'KRW',
        currencyDisplay: 'narrowSymbol' // 화폐 기호 축소 
    }).format(numPrice);
};

// 날짜 포맷팅 함수 
const formatDate = (timestamp) => {
    if (!timestamp) return '없음';

    // 날짜 객체로 변환 
    let date;
    if (timestamp.toDate && typeof timestamp.toDate === 'function') {
        // Firebase Timestamp 객체인 경우 
        date = timestamp.toDate();
    } else if (timestamp.seconds) {
        // Firebase Timestamp와 유사한 객체인 경우 
        date = new Date(timestamp.seconds * 1000);
    } else {
        // 이미 Date 객체이거나 다른 형식인 경우 
        date = new Date(timestamp);
    }

    // 날짜가 유효하지 않은 경우 
    if (isNaN(date.getTime())) return '날짜 오류';

    // 날짜 포맷팅 
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hour = String(date.getHours()).padStart(2, '0');
    const minute = String(date.getMinutes()).padStart(2, '0');

    return `${year}년 ${month}월 ${day}일 ${hour}: ${minute}분`;
}

const checkAdminRole = async (userId) => {
    try {
        const userDocRef = doc(db, "users", userId);
        const userDoc = await getDoc(userDocRef);

        if (userDoc.exists() && userDoc.data().role === 'admin') {
            return true;
        }
        return false;
    } catch (error) {
        console.error("관리자 여부 확인 실패:", error.message);
        return false;
    }
};

// Firestore에서 예약 데이터 가져오기 
const fetchAllReservations = async () => {
    try {
        // UID를 동적으로 변경 (사용자의 UID를 매개변수로 받음)
        const reservationCol = collection(db, "reservations");
        const snapshot = await getDocs(reservationCol);
        const allReservations = [];

        snapshot.forEach(docSnapshot => {
            const userId = docSnapshot.id;
            const data = docSnapshot.data();
            if (data && data.reservation && Array.isArray(data.reservation)) {
                // 각 reservation 항목에 사용자 ID 추가 
                const userReservations = data.reservation.map(reservation => ({
                    ...reservation,
                    userId: userId
                }));
                allReservations.push(...userReservations);
            }
        });

        console.log("가져온 예약 데이터:", allReservations.length, "건");
        return allReservations;
    } catch (error) {
        console.error("예약 데이터 가져오기 실패:", error.message);
        return [];
    }
};

const renderReservationData = (reservations) => {
    userDataList.innerHTML = ""; // 기존 내용 초기화

    if (!reservations || !reservations.length === 0) {
        userDataList.innerHTML = "<tr><td colspan='6'> 예약 데이터가 없습니다.</td></tr>";
        return;
    }
    console.log(`총 ${reservations.length}개의 예약 데이터를 표시합니다.`);

    // reservation 배열 순회 , 모든 예약 데이터 표시 
    reservations.forEach(reservation => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
        <td>${reservation.reservationId || "없음"}</td>
        <td>${reservation.customerName || "없음"}</td>
        <td>${formatDate(reservation.reservationDate)}</td>
        <td>${formatPrice(reservation.amount)}원</td>
        <td>${reservation.seatInfo || "없음"}</td>
        `;
        userDataList.appendChild(tr);
    });
};

// displayName 표시 

onAuthStateChanged(auth, async (user) => {
    if (user) {
        // 관리자 여부 확인     
        const isAdmin = await checkAdminRole(user.uid);

        if (isAdmin) {
            // 관리자 표시 
            const displayName = user.displayName || "관리자";
            admin.textContent = `환영합니다 ${displayName}님`;

            // 예약 데이터 가져오기 
            console.log("예약 데이터 가져오기 시작");
            const allReservations = await fetchAllReservations();
            console.log("가져온 모든 예약:", allReservations);
            renderReservationData(allReservations);

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
        } else {
            // 관리자가 아닌 경우 리다이렉트 
            alert("관리자 권한이 필요합니다.");
            await signOut(auth);
            window.location.href = "index.html";
        }
    } else {
        // 로그인 되지 않은 경우 리다이렉트 
        alert("로그인이 필요합니다.");
        window.location.href = "index.html";
    }
});
