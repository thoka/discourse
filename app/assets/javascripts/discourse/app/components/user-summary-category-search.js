import Component from "@ember/component";
import { tagName } from "@ember-decorators/component";
import discourseComputed from "discourse-common/utils/decorators";

@tagName("")
export default class UserSummaryCategorySearch extends Component {
  @discourseComputed("user", "category")
  searchParams() {
    return `@${this.get("user.username")} #${this.get("category.slug")}`;
  }
}
