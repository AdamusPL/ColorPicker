import * as React from 'react';
import { BottomNavigation, Text } from 'react-native-paper';
import Values from '../pages/Values';
import PaletteChoice from '../pages/PaletteChoice';

const ValuesRoute = () => <Values />;

const PaletteRoute = () => <PaletteChoice />;

const Layout = () => {
  const [index, setIndex] = React.useState(0);
  const [routes] = React.useState([
    { key: 'values', title: 'Values', focusedIcon: 'calculate' },
    { key: 'palette', title: 'Palette', focusedIcon: 'palette' },
  ]);

  const renderScene = BottomNavigation.SceneMap({
    values: ValuesRoute,
    palette: PaletteRoute
  });

  return (
    <BottomNavigation
      navigationState={{ index, routes }}
      onIndexChange={setIndex}
      renderScene={renderScene}
    />
  );
};

export default Layout;