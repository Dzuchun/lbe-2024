#include <TFile.h>
#include <TTree.h>
#include <cstdio>
#include <unordered_set>

void task1_00(char const *input_file, char const *tree_name) {
    std::unique_ptr<TFile> treeFile(TFile::Open(input_file));
    auto tree = treeFile->Get<TTree>(tree_name);

    int runnr;
    tree->SetBranchAddress("Runnr", &runnr);

    printf("Leaves count: %d\n", tree->GetListOfLeaves()->GetSize());

    std::unordered_set<int> run_ids{};

    // src: https://root.cern/manual/trees/
    int entry;
    for (entry = 0; tree->LoadTree(entry) >= 0; ++entry) {
        // Load the data for the given tree entry
        tree->GetEntry(entry);
        run_ids.insert(runnr);
    }

    printf("Total entries: %d\n", entry);
    printf("Unique run ids: ");
    for (const auto &id : run_ids) {
        printf("%d ", id);
    }
    printf("\nRun ids count: %ld", run_ids.size());
}
