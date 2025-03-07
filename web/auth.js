import { auth } from './firebase.js';
import { signInWithEmailAndPassword } from 'firebase/auth';

export const login = async (email, password) => {
    console.log('로그인 시도:', email, password); // 입력값 확인
    try {
        const userCredential = await signInWithEmailAndPassword(auth, email, password);
        console.log('로그인 성공:', userCredential.user);
        return { success: true, user: userCredential.user };
    } catch (error) {
        console.log('로그인 실패:', error.message);
        return { success: false, message: error.message };
    }
};