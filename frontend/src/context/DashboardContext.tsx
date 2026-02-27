import { createContext, useContext, useState } from 'react';
import type { ReactNode } from 'react';

interface DashboardContextType {
    currentPeople: number;
    mealType: string;
    setMealType: (type: string) => void;
    dayStatus: string;
    setDayStatus: (status: string) => void;
    menu: string;
    setMenu: (menu: string) => void;
}

const DashboardContext = createContext<DashboardContextType | undefined>(undefined);

export const DashboardProvider = ({ children }: { children: ReactNode }) => {
    const [currentPeople] = useState(85); // Assuming this might be dynamic later
    const [mealType, setMealType] = useState('Lunch');
    const [dayStatus, setDayStatus] = useState('Normal Day');
    const [menu, setMenu] = useState('Roti, Rice, Daal, Paneer, Gulab Jamun');

    return (
        <DashboardContext.Provider value={{ currentPeople, mealType, setMealType, dayStatus, setDayStatus, menu, setMenu }}>
            {children}
        </DashboardContext.Provider>
    );
};

export const useDashboard = () => {
    const context = useContext(DashboardContext);
    if (context === undefined) {
        throw new Error('useDashboard must be used within a DashboardProvider');
    }
    return context;
};
