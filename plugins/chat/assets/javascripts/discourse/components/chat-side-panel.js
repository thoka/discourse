import Component from "@glimmer/component";
import { inject as service } from "@ember/service";

export default class ChatSidePanel extends Component {
  @service chatStateManager;
}