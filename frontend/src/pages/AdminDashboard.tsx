import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useDashboard } from '../context/DashboardContext';

const AdminDashboard = () => {
    const navigate = useNavigate();
    const { currentPeople, mealType, dayStatus, setDayStatus, menu, setMenu } = useDashboard();

    const [draftDayStatus, setDraftDayStatus] = useState(dayStatus);
    const [draftMenu, setDraftMenu] = useState(menu);

    useEffect(() => {
        setDraftDayStatus(dayStatus);
        setDraftMenu(menu);
    }, [dayStatus, menu]);

    const handleSetState = () => {
        setDayStatus(draftDayStatus);
        setMenu(draftMenu);
    };

    const handleLogout = () => {
        navigate('/login');
    };

    return (
        <div className="flex-col h-screen" style={{ overflowY: 'auto', backgroundColor: 'var(--color-white)' }}>
            {/* Navbar */}
            <nav className="navbar">
                <h2>Mess Monitoring System - Admin Panel</h2>
                <button onClick={handleLogout} className="btn btn-outline" style={{ padding: '0.5rem 1rem' }}>
                    Logout
                </button>
            </nav>

            {/* Main Content */}
            <main className="container p-6 flex flex-col" style={{ gap: '3rem' }}>
                <h1 className="mb-6">Admin Dashboard</h1>

                {/* Current Status Section */}
                <section className="card" >
                    <h2 className="mb-4">Current Status</h2>
                    <div className="grid md:grid-cols-3 gap-6">
                        <div className="flex-col justify-center">
                            <span style={{ fontWeight: 600, opacity: 0.8 }}>Current People:</span>
                            <div style={{ fontSize: '2.5rem', fontWeight: 700, color: 'var(--color-dark-blue)' }}>
                                {currentPeople}
                            </div>
                        </div>

                        <div className="flex-col justify-center">
                            <span style={{ fontWeight: 600, opacity: 0.8, marginBottom: '8px' }}>Current Meal Type:</span>
                            <span className="badge badge-outline" style={{ alignSelf: 'flex-start', fontSize: '1rem' }}>
                                {mealType}
                            </span>
                        </div>

                        <div className="flex-col justify-center">
                            <span style={{ fontWeight: 600, opacity: 0.8, marginBottom: '8px' }}>Current Day Status:</span>
                            <span className="badge badge-solid" style={{ alignSelf: 'flex-start', fontSize: '1rem' }}>
                                {dayStatus}
                            </span>
                        </div>
                    </div>
                </section>

                {/* Controls Section */}
                <section className="card">
                    <h2 className="mb-6">Controls</h2>

                    <div className="grid md:grid-cols-2 gap-8">
                        {/* Special Day Toggles */}
                        <div className="flex-col gap-2">
                            <label htmlFor="dayStatus" style={{ fontSize: '1.2rem', fontWeight: 600 }}>Toggle Special Day</label>
                            <select
                                id="dayStatus"
                                className="input"
                                value={draftDayStatus}
                                onChange={(e) => setDraftDayStatus(e.target.value)}
                                style={{ cursor: 'pointer', padding: '1rem', fontSize: '1.1rem' }}
                            >
                                {['Normal Day', 'Exam Day', 'Feast', 'Holiday'].map(day => (
                                    <option key={day} value={day}>{day}</option>
                                ))}
                            </select>
                        </div>

                        {/* Special Menu Toggles */}
                        <div className="flex-col gap-2">
                            <label htmlFor="menu" style={{ fontSize: '1.2rem', fontWeight: 600 }}>Special Menu</label>
                            <textarea
                                id="menu"
                                className="input"
                                value={draftMenu}
                                onChange={(e) => setDraftMenu(e.target.value)}
                                style={{ padding: '1rem', fontSize: '1.1rem', minHeight: '100px', resize: 'vertical' }}
                                placeholder="Enter the special menu for today..."
                            />
                        </div>
                    </div>

                    <div className="mt-20 flex justify-center">
                        <button
                            className="btn"
                            style={{ padding: '0.8rem 2rem', fontSize: '1.1rem' }}
                            onClick={handleSetState}
                        >
                            Set
                        </button>
                    </div>
                </section>

                <section className="card">
                    <div className="grid md:grid-cols-2 gap-8"></div>
                    <div className="mt-8 pt-6">
                        <button className="btn" style={{ padding: '1rem 2rem' }} onClick={() => alert('Opening Historical Data Modal/Page...')}>
                            View Historical Data
                        </button>
                    </div>
                </section>

            </main>
        </div>
    );
};

export default AdminDashboard;
