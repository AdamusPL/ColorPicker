import * as React from 'react';
import { BottomNavigation, Text } from 'react-native-paper';
import Values from '../pages/Values';
import Palette from '../pages/Palette';

const ValuesRoute = () => <Values />;

const PaletteRoute = () => <Palette />;

const Layout = () => {
  const [index, setIndex] = React.useState(0);
  const [routes] = React.useState([
    { key: 'values', title: 'Values'},
    { key: 'palette', title: 'Palette'},
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