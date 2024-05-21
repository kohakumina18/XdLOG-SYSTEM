import React, { useState, useEffect } from "react";
import { Route, Routes, Link, useNavigate } from "react-router-dom";
import DangNhap from "./DangNhap"
import SoDauBai from "./SoDauBai";
import XemLichDay from "./XemLichDay";
import ThongBao from "./ThongBao";
import Minigames from "./Minigames";
import ThongKe from "./ThongKe";
import "./GiaoVienDashboard.css"; 
import LienLac from "./LienLac";

const GiaoVienDashboard = () => {
    const [isLoggedOut, setIsLoggedOut] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        const storedUser = JSON.parse(localStorage.getItem("USER_LOGIN"));
        if (!storedUser) {
            setIsLoggedOut(true);
            navigate('/dangnhap');
        }
    }, []);

    const handleLogout = () => {
        localStorage.removeItem("USER_LOGIN");
        setIsLoggedOut(true);
        navigate('/dangnhap'); 
    };

    const storedUser = JSON.parse(localStorage.getItem("USER_LOGIN"));

    return (
        <>
            {isLoggedOut ? (
                <DangNhap />
            ) : (
                <div className="giaoVienDashboard">
                    <div className="top">
                        <h3>xdLOG</h3>
                        <h1>Another Shining Day, Teacher!</h1>
                        <h2>{storedUser && storedUser.hoten}</h2>
                    </div>
                    <div className="cent">
                        <div className="left">
                            <nav className="dashboard">
                                <Link to="/"><i className="fa-solid fa-book"></i>Sổ đầu bài</Link>
                                <Link to="/xemlichday"><i className="fa-solid fa-calendar"></i>Xem lịch dạy</Link>
                                <Link to="/thongbao"><i className="fa-solid fa-bell"></i>Thông báo</Link>
                                <Link to="/minigames"><i className="fa-solid fa-gamepad"></i>Minigames</Link>
                                <Link to="/thongke"><i className="fa-solid fa-chart-simple"></i>Thống kê</Link>
                                <Link to="/lienlac"><i className="fa-solid fa-phone"></i>Liên lạc</Link>
                            </nav>
                            <div className="leftBottom">
                                <ul>
                                    <li><i className="fa-solid fa-gear"></i>Cài đặt</li>
                                    <li onClick={handleLogout}><i className="fa-solid fa-right-from-bracket"></i>Đăng xuất</li>
                                </ul>
                            </div>
                        </div>
                        <div className="right">
                            <Routes>
                                <Route path="/" element={<SoDauBai />}></Route>
                                <Route path="/xemlichday" element={<XemLichDay />}></Route>
                                <Route path="/thongbao" element={<ThongBao />}></Route>
                                <Route path="/minigames" element={<Minigames />}></Route>
                                <Route path="/thongke" element={<ThongKe />}></Route>
                                <Route path="/lienlac" element={<LienLac />}></Route>
                            </Routes>
                        </div>
                    </div>
                </div>
            )}
        </>
    );
}

export default GiaoVienDashboard;
