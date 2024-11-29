import { gt } from "truth-helpers";
import number from "discourse/helpers/number";
import icon from "discourse-common/helpers/d-icon";

const OpLikesCell = <template>
  <td class="num likes">
    {{#if (gt @topic.op_like_count 0)}}
      <a href={{@topic.summaryUrl}}>
        {{number @topic.op_like_count}}
        {{icon "heart"}}
      </a>
    {{/if}}
  </td>
</template>;

export default OpLikesCell;
