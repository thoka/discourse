const Header = <template>
  <tr>
    {{#each @columns as |entry|}}
      <entry.value.header
        @sortable={{@sortable}}
        @activeOrder={{@order}}
        @changeSort={{@changeSort}}
        @ascending={{@ascending}}
        @category={{@category}}
        @name={{@listTitle}}
        @bulkSelectEnabled={{@bulkSelectEnabled}}
        @showBulkToggle={{@toggleInTitle}}
        @canBulkSelect={{@canBulkSelect}}
        @canDoBulkActions={{@canDoBulkActions}}
        @showTopicsAndRepliesToggle={{@showTopicsAndRepliesToggle}}
        @newListSubset={{@newListSubset}}
        @newRepliesCount={{@newRepliesCount}}
        @newTopicsCount={{@newTopicsCount}}
        @bulkSelectHelper={{@bulkSelectHelper}}
        @changeNewListSubset={{@changeNewListSubset}}
      />
    {{/each}}
  </tr>
</template>;

export default Header;
