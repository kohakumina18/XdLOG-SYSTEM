import React, { useEffect, useState } from "react";
import "./DangNhap.css";
import { useNavigate } from "react-router-dom";
import GiaoVienDashboard from "./GiaoVienDashboard";
import AdminDashboard from "./AdminDashboard";
import GVCNDashboard from "./GVCNDashboard";
import BGHDashboard from "./BGHDashboard";
import TTBMDashboard from "./TTBMDashBoard"; 
import axios from "axios";


const DangNhap = () => {
    const navigate = useNavigate();

    const [users, setUsers] = useState([]);
    const [isLoggedIn, setIsLoggedIn] = useState(false);
    const [value, setValue] = useState({
        username: "",
        password: "",
        role: "",
    });

    const fetchApi = async () => {
        try {
            const res = await axios.get("https://6645926bb8925626f8924451.mockapi.io/permissionLogin");
            if (res.status === 200) {
                setUsers(res.data);
                const storedUser = localStorage.getItem("USER_LOGIN");
                if (storedUser) {
                    const parsedUser = JSON.parse(storedUser);
                    if (parsedUser.role) {
                        setIsLoggedIn(true);
                        setValue(parsedUser);
                    }
                }
            }
        } catch (error) {
            console.error("Khong the fetch api. Loi:", error.message);
        }
    };

    useEffect(() => {
        fetchApi();
    }, []);

    const handleInput = (e) => {
        setValue({
            ...value,
            [e.target.name]: e.target.value,
        });
    };

    const handleLogin = () => {
        const user = users.find(
            (user) => user.username === value.username && user.password === value.password
        );
        if (user) {
            localStorage.setItem("USER_LOGIN", JSON.stringify(user));
            setIsLoggedIn(true);
            setValue(user);
            // Redirect based on user role
            switch (user.role) {
                case "admin":
                    navigate('/admindashboard');
                    break;
                case "gv":
                    navigate('/giaoviendashboard');
                    break;
                case "ttbm":
                    navigate('/ttbmdashboard');
                    break;
                case "bgh":
                    navigate('/bghdashboard');
                    break;
                case "gvcn":
                    navigate('/gvcndashboard');
                    break;
                default:
                    navigate('/defaultdashboard'); // Default redirect for unknown roles
                    break;
            }
        } else {
            alert('Login failed');
        }
    };
    

    return (
        <>
            {isLoggedIn && value.role ? (
                <>
                    {value.role === "admin" && <AdminDashboard />}
                    {value.role === "gv" && <GiaoVienDashboard />}
                    {value.role === "ttbm" && <TTBMDashboard />}
                    {value.role === "bgh" && <BGHDashboard />}
                    {value.role === "gvcn" && <GVCNDashboard />}
                </>
            ) : (
                <div className="login">
                    <div className="top">
                        <h3>xdLOG</h3>
                    </div>
                    <div className="center">
                        <p className="hello">xdLOG, xin chào!</p>
                        <div>
                            <div className="input">
                                <h4>Tài khoản</h4>
                                <input
                                    name="username"
                                    onChange={handleInput}
                                    type="text"
                                    placeholder="Nhập tên tài khoản"
                                />
                            </div>
                            <div className="input">
                                <h4>Mật khẩu</h4>
                                <input
                                    name="password"
                                    onChange={handleInput}
                                    type="password"
                                    placeholder="******"
                                />
                            </div>
                        </div>
                        <button onClick={handleLogin}>Đăng nhập</button>
                    </div>
                </div>
            )}
        </>
    );
};

export default DangNhap;
