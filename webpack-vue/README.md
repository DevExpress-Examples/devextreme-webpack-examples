# DevExtreme with Vite and Vue example

This [Vue](https://vuejs.org/) example displays DevExtreme widgets loading only required modules. The application contains a button (a [dxButton](https://js.devexpress.com/Documentation/ApiReference/UI_Components/dxButton/) widget). When you click this button, a [DevExpress dialog](https://js.devexpress.com/Documentation/ApiReference/Common/Utils/ui/dialog/#alertmessageHtml_title) displays "Hello world!". The example uses [Vite](https://vitejs.dev/) for fast development and optimized builds.

**Technologies:** Vue 3.5, DevExtreme 25.1.3, Vite 6

## Getting Started

1. Clone the repository.
 ``` text
 git clone https://github.com/DevExpress-Examples/devextreme-webpack-examples.git
 ```

2. Go to the project folder.
 ``` text
 cd webpack-vue
 ```

3. Install the required modules.
 ``` text
 npm install
 ```

4. Start the development server.
 ``` text
 npm run dev
 ```
 This will start Vite dev server with hot module replacement at http://localhost:9900.

Alternatively, you can:
 - Build for production: `npm run build`
 - Preview production build: `npm run preview`

## Resources

For detailed information on modularity, see the [DevExtreme Modularity Guide](https://js.devexpress.com/Documentation/Guide/Common/Modularity/Link_Modules/).

For Vite documentation, visit [Vite Guide](https://vitejs.dev/guide/).
