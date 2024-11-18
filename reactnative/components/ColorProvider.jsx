import { createContext, useContext, useState } from "react";

const ColorContext = createContext();

export default function ColorProvider({children}){
    const [selectedColor, setSelectedColor] = useState('rgb(0, 0, 0)');

    return (
        <ColorContext.Provider value={{ selectedColor, setSelectedColor }}>
            {children}
        </ColorContext.Provider>
    );
}

export const useColor = () => useContext(ColorContext);