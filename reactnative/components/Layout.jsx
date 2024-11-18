import * as React from 'react';
import { BottomNavigation, Text } from 'react-native-paper';
import Values from '../pages/Values';
import PaletteChoice from '../pages/PaletteChoice';
import { Image } from 'react-native';
import ColorProvider from './ColorProvider';

const Layout = () => {
  const [index, setIndex] = React.useState(0);
  const [routes] = React.useState([
    {
      key: 'values',
      title: 'Konwerter',
      focusedIcon: ({ size, color }) => (
        <Image
          source={require('./images/calculate.png')}
          style={{ width: size, height: size, tintColor: color }}
        />
      ),
      unfocusedIcon: require('./images/calculate.png')
    },
    {
      key: 'palette',
      title: 'Paleta',
      focusedIcon: ({ size, color }) => (
        <Image
          source={require('./images/palette.png')}
          style={{ width: size, height: size, tintColor: color }}
        />
      ),
      unfocusedIcon: require('./images/palette.png')
    },
  ]);

  const ValuesRoute = () => <Values />;

  const PaletteRoute = () => <PaletteChoice />;

  const renderScene = BottomNavigation.SceneMap({
    values: ValuesRoute,
    palette: PaletteRoute
  });

  return (
    <ColorProvider>
      <BottomNavigation
        navigationState={{ index, routes }}
        onIndexChange={setIndex}
        renderScene={renderScene}
        activeColor='#FFC107'
        inactiveColor='#888888'
        barStyle={{ backgroundColor: '#FFFFFF' }}
        sceneAnimationEnabled={true}
        activeIndicatorStyle={{ backgroundColor: 'transparent' }}
        shifting={false}
      />
    </ColorProvider>
  );
};

export default Layout;