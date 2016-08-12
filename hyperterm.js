module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 14,

    // font family with optional fallbacks
    fontFamily: 'Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

    // terminal cursor background color (hex)
    cursorColor: '#F81CE5',

    // color of the text
    foregroundColor: '#fff',

    // terminal background color
    backgroundColor: '#000',

    // border color (window, tabs)
    borderColor: '#333',

    // custom css to embed in the main window
    css: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    termCSS: '',

    // custom padding
    padding: '12px 14px',

    // some color overrides. see http://bit.ly/29k1iU2 for
    // the full list
    colors: [
      '#000000', // '#000000',
      '#C75646', // '#ff0000',
      '#8EB33B', // '#33ff00',
      '#D0B03C', // '#ffff00',
      '#72B3CC', // '#0066ff',
      '#C8A0D1', // '#cc00ff',
      '#218693', // '#00ffff',
      '#B0B0B0', // '#d0d0d0',
      '#5D5D5D', // '#808080',
      '#E09690', // '#ff0000',
      '#CDEE69', // '#33ff00',
      '#FFE377', // '#ffff00',
      '#9CD9F0', // '#0066ff',
      '#FBB1F9', // '#cc00ff',
      '#77DFD8', // '#00ffff',
      '#F7F7F7'  // '#ffffff'
    ]
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hypersolar`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hyperterm-blink',
    'hyperborder',
    'hypercwd',
    'hyperlinks',
    'hyperterm-bold-tab',
    'hyperterm-tab-icons'
  ],

  // in development, you can create a directory under
  // `~/.hyperterm_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
