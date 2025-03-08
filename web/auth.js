import { auth } from './firebase';
import { signInWithEmailAndPassword } from 'firebase/auth';

// 로그인 함수 
export const login = async (email, password) => {
    try {
        const userCredential = await signInWithEmailAndPassword(auth, email, password);
        const user = userCredential.user;
        console.log('로그인 성공', user.email);
        return { success: true, user };
    } catch (error) {
        console.error('로그인 실패:', error.code, error.message);
        return { success: false, message: error.message };
    }
};