import * as React from "react";
import { createRoot } from "react-dom/client";

import "devextreme/dist/css/dx.common.css";
import "devextreme/dist/css/dx.light.compact.css";

import ButtonExample from "./button-example";

const root = createRoot(document.getElementById("app"));
root.render(
  <div>
    <ButtonExample />
  </div>
);
