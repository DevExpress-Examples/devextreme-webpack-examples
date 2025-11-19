# DevExtreme with a Webpack and React example

This [React](https://react.dev/) example displays DevExtreme widgets loading only required modules. The application contains a button (a [dxButton](https://js.devexpress.com/Documentation/ApiReference/UI_Components/dxButton/) widget). When you click this button, an [alert dialog](https://js.devexpress.com/Documentation/ApiReference/Common/Utils/ui/dialog/#alertmessageHtml_title) appears. The example requires [Webpack](https://webpack.js.org/concepts/) to be installed.

**Technologies:** React 18, DevExtreme 25.1.3, Webpack 4, Babel 7

## Getting Started

1. Clone the repository.
 ``` text
 git clone https://github.com/DevExpress-Examples/devextreme-webpack-examples.git
 ```

2. Go to the project folder.
 ``` text
 cd webpack-react
 ```

3. Install the required modules.
 ``` text
 npm install
 ```

4. Build and serve the application.
 ``` text
 npm start
 ```
 This will build the bundle and automatically open the application in your browser at http://localhost:8080.

Alternatively, you can:
 - Use webpack-dev-server with live reload: `npm run serve`
 - Build manually: `npm run build`

## Resources

For detailed information on modularity, see the [DevExtreme Modularity Guide](https://js.devexpress.com/React/Documentation/Guide/React_Components/Add_DevExtreme_to_a_React_Application/#Additional_Configuration_for_Webpack).
