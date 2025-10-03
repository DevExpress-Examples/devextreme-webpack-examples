import * as React from "react";
import { Button } from "devextreme-react/button";
import { alert } from "devextreme/ui/dialog";

export default class extends React.Component {
    handleClick = () => {
        alert("Hello world!", "", false);
    }

    render() {
        return (
            <Button 
                text="Say 'Hello world'" 
                onClick={this.handleClick}
            />
        );
    }
}
